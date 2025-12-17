<!-- 20251217新增功能 - 个人中心与浏览足迹 -->
<script setup>
import { ref, reactive, onMounted, inject } from 'vue'
import { useStore } from '@/stores/my'
import Top from '@/components/Top.vue' // 引入顶部导航

const store = useStore()
const axios = inject('axios')
const activeTab = ref('timeline') // 默认显示时间轴
const activities = ref([]) // 日志数据

// 颜色映射：不同操作显示不同颜色
const typeColors = {
  'BROWSE': '#909399', // 灰色
  'COMMENT': '#409EFF', // 蓝色
  'LOGIN': '#67C23A'    // 绿色
}

function loadLogs() {
  // 严谨判断：必须已登录且 id 存在
  if (!store.user.user || !store.user.user.id) {
    console.warn("无法加载日志：未获取到用户ID")
    return
  }

  const userId = store.user.user.id

  axios.get('/api/oplog/getMyLogs?userId=' + userId)
    .then(res => {
      if (res.data.success) {
        activities.value = res.data.map.logs
      }
    })
    .catch(err => {
      console.error("加载日志失败", err)
    })
}

onMounted(() => {
  loadLogs()
})
</script>

<template>
  <el-affix>
    <Top />
  </el-affix>

  <div class="center-container">
    <el-row :gutter="20">
      <el-col :span="8">
        <el-card class="box-card" shadow="hover">
          <div class="user-header">
            <el-avatar :size="100" src="https://cube.elemecdn.com/0/88/03b0d39583f48206768a7534e55bcpng.png" />
            <h3>{{ store.user.user?.name || '未登录' }}</h3>
            <p>{{ store.user.user?.email || '暂无邮箱' }}</p>
          </div>
          <el-divider />
          <div class="user-stats">
            <div class="stat-item">
              <div class="num">12</div>
              <div class="label">文章</div>
            </div>
            <div class="stat-item">
              <div class="num">58</div>
              <div class="label">评论</div>
            </div>
          </div>
        </el-card>
      </el-col>

      <el-col :span="16">
        <el-card shadow="hover">
          <el-tabs v-model="activeTab">

            <el-tab-pane label="我的足迹" name="timeline">
              <el-timeline v-if="activities.length > 0">
                <el-timeline-item v-for="(activity, index) in activities" :key="index"
                  :color="typeColors[activity.type]" :timestamp="activity.created" placement="top">
                  <el-card class="timeline-card">
                    <h4>{{ activity.type === 'COMMENT' ? '发表了评论' : '浏览了文章' }}</h4>
                    <p>
                      {{ activity.content }}
                      <router-link v-if="activity.targetId" :to="'/article_comment/' + activity.targetId">
                        (点击查看)
                      </router-link>
                    </p>
                  </el-card>
                </el-timeline-item>
              </el-timeline>
              <el-empty v-else description="暂无足迹" />
            </el-tab-pane>

            <el-tab-pane label="详细资料" name="info">
              <el-descriptions title="基本信息" :column="1" border>
                <el-descriptions-item label="用户名">{{ store.user.user?.username }}</el-descriptions-item>
                <el-descriptions-item label="昵称">{{ store.user.user?.name }}</el-descriptions-item>
                <el-descriptions-item label="角色">
                  <el-tag size="small">{{ store.user.user?.authorities?.[0] }}</el-tag>
                </el-descriptions-item>
                <el-descriptions-item label="注册时间">2025-12-16</el-descriptions-item>
              </el-descriptions>
            </el-tab-pane>
          </el-tabs>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<style scoped>
.center-container {
  max-width: 1200px;
  margin: 20px auto;
  padding: 0 20px;
}

.user-header {
  text-align: center;
}

.user-header h3 {
  margin: 10px 0 5px;
}

.user-header p {
  color: #999;
  font-size: 14px;
}

.user-stats {
  display: flex;
  justify-content: space-around;
  text-align: center;
}

.stat-item .num {
  font-size: 20px;
  font-weight: bold;
  color: #409EFF;
}

.stat-item .label {
  font-size: 12px;
  color: #909399;
}

.timeline-card {
  padding: 10px;
}

.timeline-card h4 {
  margin: 0 0 10px;
  font-size: 16px;
}

.timeline-card p {
  margin: 0;
  color: #666;
}
</style>