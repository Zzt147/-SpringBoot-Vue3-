<script setup>
import { defineProps, inject, ref } from 'vue'
import { Trophy, StarFilled, View } from '@element-plus/icons-vue'

// 接收两个列表数据
const props = defineProps({
  readList: { type: Array, default: () => [] }, // 阅读榜数据
  likeList: { type: Array, default: () => [] }  // 点赞榜数据
})

const toArticle = inject('toArticle')
const currentTab = ref('read') // 当前选中的标签: 'read' 或 'like'

function gotoArticle(article) {
  toArticle(article)
}
</script>

<template>
  <el-card shadow="never" class="ranking-card">
    <div class="ranking-header">
      <div class="tab-item" :class="{ active: currentTab === 'read' }" @click="currentTab = 'read'">
        <el-icon>
          <View />
        </el-icon> 阅读榜
      </div>
      <div class="divider">|</div>
      <div class="tab-item" :class="{ active: currentTab === 'like' }" @click="currentTab = 'like'">
        <el-icon>
          <StarFilled />
        </el-icon> 点赞榜
      </div>
    </div>

    <div class="ranking-list">
      <div v-for="(article, index) in (currentTab === 'read' ? readList : likeList)" :key="article.id" class="item">
        <div class="rank-num" :class="{ 'top3': index < 3 }">{{ index + 1 }}</div>

        <div class="content" @click="gotoArticle(article)">
          <div class="title" :title="article.title">{{ article.title }}</div>
          <div class="meta">
            <template v-if="currentTab === 'read'">
              <el-icon>
                <View />
              </el-icon> {{ article.hits || 0 }}
            </template>
            <template v-else>
              <el-icon>
                <StarFilled />
              </el-icon> {{ article.likes || 0 }}
            </template>
          </div>
        </div>
      </div>

      <div v-if="(currentTab === 'read' ? readList : likeList).length === 0" class="empty">
        暂无数据
      </div>
    </div>
  </el-card>
</template>

<style scoped>
/* 头部切换样式 */
.ranking-header {
  display: flex;
  align-items: center;
  justify-content: center;
  padding-bottom: 15px;
  border-bottom: 1px solid #eee;
  margin-bottom: 15px;
  font-size: 16px;
  font-weight: bold;
}

.tab-item {
  cursor: pointer;
  padding: 5px 10px;
  color: #999;
  transition: all 0.3s;
  display: flex;
  align-items: center;
  gap: 5px;
}

.tab-item.active {
  color: #409EFF;
  /* 激活颜色 */
  transform: scale(1.05);
}

.tab-item:hover {
  color: #666;
}

.divider {
  color: #eee;
  margin: 0 10px;
}

/* 列表样式 */
.item {
  display: flex;
  align-items: center;
  margin-bottom: 15px;
  cursor: pointer;
}

.rank-num {
  width: 22px;
  height: 22px;
  text-align: center;
  line-height: 22px;
  background: #f0f2f5;
  border-radius: 4px;
  margin-right: 12px;
  font-size: 12px;
  color: #909399;
  font-weight: bold;
}

.top3 {
  background: linear-gradient(135deg, #ff9a9e 0%, #fad0c4 99%, #fad0c4 100%);
  color: #fff;
}

.content {
  flex: 1;
  overflow: hidden;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.title {
  flex: 1;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
  font-size: 14px;
  color: #333;
  margin-right: 10px;
}

.item:hover .title {
  color: #409EFF;
}

.meta {
  font-size: 12px;
  color: #999;
  display: flex;
  align-items: center;
  gap: 3px;
  min-width: 50px;
  /* 防止数字跳动 */
  justify-content: flex-end;
}

.empty {
  text-align: center;
  color: #999;
  padding: 20px 0;
  font-size: 13px;
}
</style>