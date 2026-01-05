<script setup>
import { ref, onMounted, inject, nextTick } from 'vue'
import * as echarts from 'echarts'
import { DataAnalysis, View, ChatLineRound, Trophy, Back } from '@element-plus/icons-vue'
import { ElMessage } from 'element-plus'

const axios = inject('axios')

// 基础统计数据
const stats = ref({
  totalArticles: 0,
  totalHits: 0,
  totalComments: 0
})

// 图表 DOM 引用
const pieChartRef = ref(null)
const barChartRef = ref(null)

// ECharts 实例
let pieChart = null
let barChart = null

// === 1. 饼图逻辑 (支持下钻) ===
let pieLevel0Data = [] // 顶级分类数据
let pieLevel1Map = {}  // 子分类映射表 { '技术': [{name: '前端', value: 10}, ...] }
let currentPieLevel = 0 // 0: 顶级视图, 1: 子级视图

// 处理分类数据，构建层级结构
function processCategoryData(rawList) {
  const level0Map = {}
  const level1Store = {}

  if (!rawList || rawList.length === 0) return

  rawList.forEach(item => {
    // 假设 name 格式为 "技术/前端" 或 "生活"
    const parts = item.name.split('/')
    const rootName = parts[0] // 顶级名称

    // 1. 聚合顶级数据
    if (!level0Map[rootName]) {
      level0Map[rootName] = 0
      level1Store[rootName] = []
    }
    level0Map[rootName] += item.value

    // 2. 存储子级数据
    if (parts.length > 1) {
      // 如果有子分类，去掉顶级前缀作为子分类名称
      const subName = parts.slice(1).join('/')
      level1Store[rootName].push({ name: subName, value: item.value })
    } else {
      // 如果没有斜杠，说明这本身就是顶级分类的一篇文章(或未细分)，也放入子级列表以便下钻时查看
      level1Store[rootName].push({ name: '默认', value: item.value })
    }
  })

  // 转换为 ECharts 需要的数组格式
  pieLevel0Data = Object.keys(level0Map).map(k => ({ name: k, value: level0Map[k] }))
  pieLevel1Map = level1Store
}

function initPieChart(data) {
  if (pieChart) pieChart.dispose()
  pieChart = echarts.init(pieChartRef.value)

  processCategoryData(data)

  // 初始渲染顶级视图
  renderPie(pieLevel0Data, '创作分类分布 (点击扇区查看详情)', false)

  // 点击事件处理
  pieChart.on('click', (params) => {
    // 防止点击的是返回按钮等图形元素
    if (params.componentType !== 'series') return

    if (currentPieLevel === 0) {
      const rootName = params.name
      const children = pieLevel1Map[rootName]

      // 如果有子分类数据，则下钻
      if (children && children.length > 0) {
        currentPieLevel = 1
        renderPie(children, `${rootName} - 分类详情`, true)
      } else {
        ElMessage.info(`【${rootName}】下暂无细分子类`)
      }
    }
  })

  // 点击空白处返回顶级 (可选)
  pieChart.getZr().on('click', (params) => {
    if (!params.target && currentPieLevel === 1) {
      backToLevel0()
    }
  })
}

function backToLevel0() {
  currentPieLevel = 0
  renderPie(pieLevel0Data, '创作分类分布 (点击扇区查看详情)', false)
}

function renderPie(data, title, showBack) {
  const option = {
    title: {
      text: title,
      left: 'center',
      textStyle: { fontSize: 16 }
    },
    tooltip: { trigger: 'item' },
    // 动态添加“返回”按钮
    graphic: showBack ? [
      {
        type: 'group',
        left: '10%',
        top: '10%',
        children: [
          {
            type: 'text',
            style: {
              text: '⬅ 返回顶级',
              textAlign: 'center',
              fill: '#409EFF',
              fontSize: 14,
              fontWeight: 'bold'
            },
            onclick: backToLevel0
          }
        ]
      }
    ] : [],
    series: [
      {
        name: '文章数量',
        type: 'pie',
        radius: showBack ? ['30%', '60%'] : '50%', // 下钻时变成环形更好看
        data: data,
        emphasis: {
          itemStyle: {
            shadowBlur: 10,
            shadowOffsetX: 0,
            shadowColor: 'rgba(0, 0, 0, 0.5)'
          }
        },
        label: {
          show: true,
          formatter: '{b}: {c} ({d}%)'
        }
      }
    ]
  }
  pieChart.setOption(option, { notMerge: true }) // 使用 notMerge 确保完全重绘
}

// === 2. 柱状图逻辑 (Top 15 标签) ===
function initBarChart(rawTags) {
  if (barChart) barChart.dispose()
  barChart = echarts.init(barChartRef.value)

  // 1. 数据清洗与统计
  // rawTags 是 ["Java,Spring", "Docker", ...] 这种字符串数组
  const tagCounts = {}
  if (rawTags && rawTags.length > 0) {
    rawTags.forEach(tagStr => {
      if (!tagStr) return
      // 分割并去除空白
      const tags = tagStr.replace(/，/g, ',').split(',')
      tags.forEach(t => {
        const cleanTag = t.trim()
        if (cleanTag) {
          tagCounts[cleanTag] = (tagCounts[cleanTag] || 0) + 1
        }
      })
    })
  }

  // 2. 排序并截取 Top 15
  const sortedTags = Object.keys(tagCounts)
    .map(key => ({ name: key, value: tagCounts[key] }))
    .sort((a, b) => b.value - a.value) // 降序
    .slice(0, 15)

  // 3. 渲染图表
  const option = {
    title: {
      text: '热门标签 TOP15',
      left: 'center'
    },
    tooltip: {
      trigger: 'axis',
      axisPointer: { type: 'shadow' }
    },
    grid: {
      left: '3%',
      right: '4%',
      bottom: '10%', // 留出空间给标签旋转
      containLabel: true
    },
    xAxis: {
      type: 'category',
      data: sortedTags.map(t => t.name),
      axisLabel: {
        interval: 0,
        rotate: 30, // 标签倾斜，防止重叠
        fontSize: 12
      }
    },
    yAxis: {
      type: 'value',
      name: '引用次数'
    },
    series: [
      {
        name: '文章数',
        type: 'bar',
        data: sortedTags.map(t => t.value),
        itemStyle: {
          color: new echarts.graphic.LinearGradient(0, 0, 0, 1, [
            { offset: 0, color: '#83bff6' },
            { offset: 0.5, color: '#188df0' },
            { offset: 1, color: '#188df0' }
          ])
        },
        barWidth: '50%',
        label: {
          show: true,
          position: 'top'
        }
      }
    ]
  }
  barChart.setOption(option)
}

onMounted(() => {
  // 1. 获取仪表盘基础数据 (包含分类统计)
  axios.get('/api/statistic/dashboard').then(res => {
    if (res.data.success) {
      const map = res.data.map
      stats.value.totalArticles = map.totalArticles
      stats.value.totalHits = map.totalHits
      stats.value.totalComments = map.totalComments

      // 初始化饼图
      initPieChart(map.categoryStats || [])
    }
  })

  // 2. 获取所有标签 (用于柱状图 Top 15)
  // 为了确保数据最全，我们直接调 getAllTags 接口，而不是依赖 dashboard 接口的 map
  axios.get('/api/article/getAllTags').then(res => {
    if (res.data.success) {
      const allTags = res.data.map.tags || []
      initBarChart(allTags)
    }
  })

  // 窗口大小改变时自动重绘
  window.addEventListener('resize', () => {
    pieChart && pieChart.resize()
    barChart && barChart.resize()
  })
})
</script>

<template>
  <div class="dashboard-container">
    <el-row :gutter="20" class="stat-cards">
      <el-col :span="8">
        <el-card shadow="hover" class="card-item">
          <div class="card-content">
            <el-icon :size="48" color="#409EFF">
              <DataAnalysis />
            </el-icon>
            <div class="text-info">
              <div class="label">总文章数</div>
              <div class="value">{{ stats.totalArticles }}</div>
            </div>
          </div>
        </el-card>
      </el-col>

      <el-col :span="8">
        <el-card shadow="hover" class="card-item">
          <div class="card-content">
            <el-icon :size="48" color="#67C23A">
              <View />
            </el-icon>
            <div class="text-info">
              <div class="label">总阅读量</div>
              <div class="value">{{ stats.totalHits }}</div>
            </div>
          </div>
        </el-card>
      </el-col>

      <el-col :span="8">
        <el-card shadow="hover" class="card-item">
          <div class="card-content">
            <el-icon :size="48" color="#E6A23C">
              <ChatLineRound />
            </el-icon>
            <div class="text-info">
              <div class="label">总评论数</div>
              <div class="value">{{ stats.totalComments }}</div>
            </div>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="20" style="margin-top: 20px;">
      <el-col :xs="24" :sm="12">
        <el-card shadow="hover">
          <div ref="pieChartRef" style="width: 100%; height: 400px;"></div>
        </el-card>
      </el-col>

      <el-col :xs="24" :sm="12">
        <el-card shadow="hover">
          <div ref="barChartRef" style="width: 100%; height: 400px;"></div>
        </el-card>
      </el-col>
    </el-row>

    <el-row style="margin-top: 20px;">
      <el-col :span="24">
        <el-card shadow="never" style="text-align: center; background: #fdf6ec; color: #e6a23c;">
          <h3><el-icon>
              <Trophy />
            </el-icon> 坚持写作是一种修行，继续加油！</h3>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<style scoped>
.dashboard-container {
  padding: 10px;
}

.card-content {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 10px 20px;
}

.text-info {
  text-align: right;
}

.label {
  color: #909399;
  font-size: 14px;
}

.value {
  font-size: 24px;
  font-weight: bold;
  color: #303133;
  margin-top: 5px;
}
</style>