<script setup>
import { reactive, ref, inject, onMounted } from 'vue'
import { useStore } from '@/stores/my'
import { ElMessage } from 'element-plus'

// 接收父组件传递的参数
// comment: 主评论对象
// floor: 楼层号 (1L, 2L...)
const props = defineProps(['comment', 'floor'])

const store = useStore()
const axios = inject('axios')

// --- 子评论(回复)相关数据 ---
const replies = ref([])
const replyPage = ref(1)
const replyRows = ref(3) // 默认先显示3条回复
const replyTotal = ref(0)

// 回复输入框控制
const showReplyInput = ref(false) // 是否显示输入框
const replyContent = ref('')
const currentTargetUser = ref(null) // 记录当前回复的目标用户 (null表示回复层主)

// 加载子评论
function loadReplies() {
  // 调用后端接口获取子评论 (commentId, page, rows)
  axios.get(`/api/reply/getReplies?commentId=${props.comment.id}&page=${replyPage.value}&rows=${replyRows.value}`)
    .then(res => {
      if (res.data.success) {
        replies.value = res.data.map.replies || []
        replyTotal.value = res.data.map.total || 0
      }
    })
    .catch(err => console.error("加载回复失败", err))
}

// "展示更多" 按钮逻辑
function loadMoreReplies() {
  // 每次多加载 5 条
  replyRows.value += 5
  loadReplies()
}

// 点击 "回复" 按钮
// targetUser: 如果是回复子评论中的某人，则是那个人的名字；如果是回复层主，则为 null
function triggerReply(targetUser = null) {
  // 1. 检查登录
  if (!store.user.user) {
    ElMessage.warning('请先登录后发表回复')
    return
  }

  // 2. 设置目标用户
  currentTargetUser.value = targetUser

  // 3. 显示输入框 (不清空内容，防止用户误触关闭后重开内容丢失，如需清空可在提交成功后清空)
  showReplyInput.value = true
}

// 提交回复
function submitReply() {
  if (!replyContent.value.trim()) {
    ElMessage.warning('回复内容不能为空')
    return
  }

  // 确定目标用户：如果有隐式目标就用它，否则默认是父评论的作者(层主)
  const target = currentTargetUser.value || props.comment.author

  axios.post('/api/reply/insert', {
    content: replyContent.value,     // 纯内容
    commentId: props.comment.id,     // 所属父评论ID
    // 从 store 获取当前登录用户名
    author: store.user.user.name || store.user.user.username,
    targetAuthor: target             // 被回复的人
  }).then(res => {
    if (res.data.success) {
      ElMessage.success('回复成功')

      // 重置状态
      replyContent.value = ''
      showReplyInput.value = false
      currentTargetUser.value = null

      // 刷新列表：确保能看到刚发的回复
      // 将显示数量设为当前数量+1，保证新回复不被折叠
      replyRows.value = Math.max(replyRows.value, replies.value.length + 1)
      loadReplies()
    } else {
      ElMessage.error(res.data.msg)
    }
  }).catch(() => ElMessage.error("回复失败"))
}

// 组件挂载时加载回复
onMounted(() => {
  loadReplies()
})
</script>

<template>
  <div class="comment-wrapper">
    <el-row class="main-comment-row">
      <el-col :span="3" :sm="2" class="avatar-col">
        <el-avatar shape="square" :size="40"
          src="https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png" />
      </el-col>

      <el-col :span="21" :sm="22">
        <div class="comment-header">
          <span class="user-name">{{ comment.author }}</span>
          <span class="floor-badge">{{ floor }}L</span>
        </div>

        <div class="comment-body">
          {{ comment.content }}
        </div>

        <div class="comment-actions">
          <span class="time-text">{{ comment.created }}</span>
          <el-button type="primary" link size="small" @click="triggerReply(null)">
            回复
          </el-button>
        </div>

        <div v-if="showReplyInput && !currentTargetUser" class="reply-input-area fade-in">
          <div class="reply-status-bar">
            正在回复 <el-tag size="small" type="info">层主</el-tag> :
          </div>

          <el-input v-model="replyContent" type="textarea" :rows="2" placeholder="写下你的回复..." />
          <div style="text-align: right; margin-top: 5px;">
            <el-button size="small" @click="showReplyInput = false">取消</el-button>
            <el-button type="primary" size="small" @click="submitReply">发送</el-button>
          </div>
        </div>
      </el-col>
    </el-row>

    <div v-if="replies.length > 0 || (showReplyInput && currentTargetUser)" class="sub-reply-container">

      <div v-for="reply in replies" :key="reply.id" class="reply-item">
        <div class="reply-line">
          <span class="reply-user">{{ reply.author }}</span>

          <template v-if="reply.targetAuthor && reply.targetAuthor !== comment.author">
            <span class="reply-text">回复</span>
            <span class="reply-target">@{{ reply.targetAuthor }}</span>
          </template>

          <span class="reply-colon">：</span>
          <span class="reply-content">{{ reply.content }}</span>
        </div>

        <div class="reply-actions">
          <span class="time-text">{{ reply.created }}</span>
          <el-button type="primary" link size="small" @click="triggerReply(reply.author)">
            回复
          </el-button>
        </div>
      </div>

      <div v-if="replyTotal > replies.length" class="show-more-btn">
        <span @click="loadMoreReplies">
          还有 {{ replyTotal - replies.length }} 条回复，点击查看
        </span>
      </div>

      <div v-if="showReplyInput && currentTargetUser" class="reply-input-area fade-in">
        <div class="reply-status-bar">
          正在回复 <span style="color: #409EFF; font-weight: bold;">@{{ currentTargetUser }}</span>
          <el-button link type="info" size="small" @click="triggerReply(null)"
            style="margin-left: 10px;">(切换回回复层主)</el-button> :
        </div>

        <el-input v-model="replyContent" type="textarea" :rows="2" :placeholder="`回复 @${currentTargetUser}...`" />
        <div style="text-align: right; margin-top: 5px;">
          <el-button size="small" @click="showReplyInput = false; currentTargetUser = null">取消</el-button>
          <el-button type="primary" size="small" @click="submitReply">发送</el-button>
        </div>
      </div>

    </div>
  </div>
</template>

<style scoped>
.comment-wrapper {
  padding: 15px 0;
  border-bottom: 1px solid #f0f0f0;
}

.avatar-col {
  text-align: center;
}

.comment-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 6px;
}

.user-name {
  font-weight: 600;
  font-size: 14px;
  color: #333;
}

.floor-badge {
  font-size: 12px;
  color: #909399;
  background-color: #f4f4f5;
  padding: 2px 6px;
  border-radius: 4px;
}

.comment-body {
  font-size: 14px;
  line-height: 1.6;
  color: #303133;
  margin-bottom: 8px;
  white-space: pre-wrap;
  /* 保留换行符 */
  word-break: break-all;
}

.comment-actions {
  font-size: 12px;
  color: #909399;
}

.time-text {
  margin-right: 15px;
}

/* 子评论容器样式 */
.sub-reply-container {
  margin-top: 10px;
  margin-left: 50px;
  /* 缩进效果 */
  background-color: #fafafa;
  padding: 15px;
  border-radius: 4px;
  font-size: 13px;
}

.reply-item {
  margin-bottom: 10px;
  border-bottom: 1px dashed #ebeef5;
  padding-bottom: 8px;
}

.reply-item:last-child {
  border-bottom: none;
  margin-bottom: 0;
}

.reply-user,
.reply-target {
  color: #409EFF;
  cursor: pointer;
  font-weight: 500;
}

.reply-text {
  margin: 0 4px;
  color: #909399;
}

.reply-colon {
  margin-right: 4px;
}

.reply-content {
  color: #606266;
  word-break: break-all;
}

.reply-actions {
  margin-top: 4px;
  font-size: 12px;
  color: #909399;
}

.show-more-btn {
  margin-top: 10px;
  text-align: left;
  color: #409EFF;
  font-size: 12px;
  cursor: pointer;
}

.show-more-btn:hover {
  text-decoration: underline;
}

/* 输入框区域样式 */
.reply-input-area {
  margin-top: 15px;
  background: #fff;
  padding: 10px;
  border: 1px solid #e4e7ed;
  border-radius: 4px;
}

.reply-status-bar {
  font-size: 12px;
  color: #606266;
  margin-bottom: 8px;
}

/* 简单动画 */
.fade-in {
  animation: fadeIn 0.3s;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: translateY(-5px);
  }

  to {
    opacity: 1;
    transform: translateY(0);
  }
}
</style>