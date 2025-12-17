<script setup>
import { reactive, inject, ref } from 'vue'
import { ElMessageBox, ElMessage } from 'element-plus'
import { Delete, Back, ChatLineSquare, Comment } from '@element-plus/icons-vue'

const axios = inject('axios')

// 数据状态
let myData = reactive({
  "comments": [],
  "pageParams": { "page": 1, "rows": 10, "total": 0 },
  "isFilterMode": false, // 是否处于筛选模式（查看特定用户）
  "filterAuthor": ""     // 当前筛选的用户名
})

// 1. 获取管理员分页评论列表 (默认模式)
function getAPage() {
  myData.isFilterMode = false
  myData.filterAuthor = ""

  axios.post('/api/comment/getAdminPage', myData.pageParams)
    .then((response) => {
      if (response.data.success) {
        // 兼容后端返回结构，确保列表不为空
        myData.comments = response.data.map.comments || []
        // 更新分页总数
        if (response.data.map.pageParams) {
          myData.pageParams.total = response.data.map.pageParams.total
        }
      } else {
        myData.comments = []
        ElMessage.warning(response.data.msg || '获取数据失败')
      }
    })
    .catch(() => {
      ElMessage.error("系统错误！")
    })
}

// 2. 获取某用户的所有评论 (筛选模式)
function getUserComments(author) {
  myData.isFilterMode = true
  myData.filterAuthor = author

  // 注意：此处假设后端接口 /api/comment/getUserComments?author=xxx 返回该用户所有评论
  axios.post('/api/comment/getUserComments?author=' + author)
    .then(res => {
      if (res.data.success) {
        myData.comments = res.data.map.comments || []
        // 筛选模式下，前端暂时显示总条数，暂不支持后端分页（除非后端接口也支持分页）
        myData.pageParams.total = myData.comments.length
        // 筛选模式重置页码为1（如果做纯前端展示）
        myData.pageParams.page = 1
      } else {
        ElMessage.warning(res.data.msg)
      }
    })
    .catch(() => ElMessage.error("获取用户评论失败"))
}

// 初始化加载
getAPage()

// 分页改变处理 (仅在非筛选模式下有效)
function handleSizeChange(newRows) {
  if (myData.isFilterMode) return // 筛选模式暂不处理每页条数变化
  myData.pageParams.rows = newRows
  myData.pageParams.page = 1
  getAPage()
}

function handleCurrentChange(newPage) {
  if (myData.isFilterMode) return // 筛选模式暂不处理翻页
  myData.pageParams.page = newPage
  getAPage()
}

// 删除逻辑
const dialogVisible = ref(false)
let deleteTarget = reactive({ id: 0, type: 'COMMENT' }) // 记录要删除的ID和类型

function showDeleteDialog(row) {
  deleteTarget.id = row.id
  // 根据数据中的 type 字段判断是主评论还是子回复
  // 假设后端 UserCommentVO 返回了 type: 'COMMENT' 或 'REPLY'
  deleteTarget.type = row.type || 'COMMENT'
  dialogVisible.value = true
}

function confirmDelete() {
  // 根据类型调用不同的删除接口 (或者统一接口)
  // 这里假设区分接口，如果你的后端统一了接口，可以简化
  let url = '/api/comment/deleteById?id=' + deleteTarget.id
  if (deleteTarget.type === 'REPLY') {
    url = '/api/reply/deleteById?id=' + deleteTarget.id // 需确保后端有此接口
  }

  axios.post(url)
    .then((response) => {
      if (response.data.success) {
        ElMessage.success("删除成功")
        dialogVisible.value = false
        // 刷新列表：如果在筛选模式，刷新筛选列表；否则刷新主列表
        if (myData.isFilterMode) {
          getUserComments(myData.filterAuthor)
        } else {
          getAPage()
        }
      } else {
        ElMessage.error(response.data.msg)
      }
    })
    .catch(() => ElMessage.error("删除失败"))
}
</script>

<template>
  <el-row>
    <el-col :span="24">
      <h4 style="margin-left: 10px; display: flex; align-items: center; gap: 10px;">
        <el-button v-if="myData.isFilterMode" :icon="Back" circle size="small" @click="getAPage" title="返回所有评论" />
        <span>{{ myData.isFilterMode ? `用户 "${myData.filterAuthor}" 的所有评论` : '评论管理' }}</span>
      </h4>
    </el-col>
  </el-row>

  <el-row>
    <el-col :span="24">
      <el-table :data="myData.comments" stripe border style="width: 100%">
        <el-table-column prop="id" label="ID" width="70" align="center" />

        <el-table-column label="评论内容" min-width="300">
          <template #default="scope">
            <div style="display: flex; align-items: flex-start; gap: 5px;">
              <el-tag size="small" :type="scope.row.type === 'REPLY' ? 'warning' : 'success'" effect="plain">
                {{ scope.row.type === 'REPLY' ? '回复' : '评论' }}
              </el-tag>

              <router-link :to="'/article_comment/' + (scope.row.refId || scope.row.articleId)" target="_blank"
                class="content-link" :title="'点击查看文章: ' + (scope.row.targetName || '详情')">
                {{ scope.row.content }}
              </router-link>
            </div>
          </template>
        </el-table-column>

        <el-table-column label="发布人" width="130" align="center">
          <template #default="scope">
            <span class="author-link" @click="getUserComments(scope.row.author)" title="点击查看该用户所有评论">
              {{ scope.row.author }}
            </span>
          </template>
        </el-table-column>

        <el-table-column label="所属对象" width="200" :show-overflow-tooltip="true">
          <template #default="scope">
            <span style="color: #909399; font-size: 13px;">
              <el-icon style="vertical-align: middle">
                <ChatLineSquare />
              </el-icon>
              {{ scope.row.targetName || ('ID: ' + scope.row.refId) }}
            </span>
          </template>
        </el-table-column>

        <el-table-column prop="created" label="发布时间" width="120" align="center" />

        <el-table-column label="操作" width="100" align="center">
          <template #default="scope">
            <el-button type="danger" link @click="showDeleteDialog(scope.row)" :icon="Delete">
              删除
            </el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-col>
  </el-row>

  <el-row v-if="!myData.isFilterMode" justify="center" align="middle" style="margin-top: 20px;">
    <el-col :span="24" style="text-align: center;">
      <el-pagination v-model:current-page="myData.pageParams.page" v-model:page-size="myData.pageParams.rows"
        :page-sizes="[5, 10, 20, 50]" layout="total, sizes, prev, pager, next, jumper" :total="myData.pageParams.total"
        @size-change="handleSizeChange" @current-change="handleCurrentChange" />
    </el-col>
  </el-row>

  <el-dialog v-model="dialogVisible" title="警告" width="300px" center>
    <div style="text-align: center;">
      <el-icon color="#F56C6C" size="24px">
        <Delete />
      </el-icon>
      <p>确定要删除这条{{ deleteTarget.type === 'REPLY' ? '回复' : '评论' }}吗？</p>
      <p style="font-size: 12px; color: #999;">操作不可恢复</p>
    </div>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="dialogVisible = false" size="small">取消</el-button>
        <el-button type="danger" @click="confirmDelete" size="small">确定删除</el-button>
      </span>
    </template>
  </el-dialog>
</template>

<style scoped>
/* 链接样式 */
.content-link {
  text-decoration: none;
  color: #606266;
  transition: color 0.2s;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  /* 最多显示2行 */
  -webkit-box-orient: vertical;
}

.content-link:hover {
  color: #409EFF;
  text-decoration: underline;
}

.author-link {
  cursor: pointer;
  color: #409EFF;
  font-weight: 500;
}

.author-link:hover {
  text-decoration: underline;
  color: #66b1ff;
}
</style>