<script setup>
import { dateFormat } from "@/js/tool.js"
import { ref, computed } from 'vue'

const props = defineProps(['article'])
const size = ref(40)

// 专门处理时间戳格式的日期
const formatDate = (dateInput) => {
  if (!dateInput) return '未知日期'

  console.log('原始日期输入:', dateInput, '类型:', typeof dateInput)

  try {
    let date

    // 如果是数字时间戳（如 1717401600000）
    if (typeof dateInput === 'number' || /^\d+$/.test(dateInput)) {
      const timestamp = typeof dateInput === 'number' ? dateInput : parseInt(dateInput)

      // 检查时间戳长度，如果是10位（秒）则乘以1000转换为毫秒
      if (timestamp.toString().length === 10) {
        date = new Date(timestamp * 1000)
      } else {
        date = new Date(timestamp)
      }
    }
    // 如果是字符串日期
    else if (typeof dateInput === 'string') {
      date = new Date(dateInput)
    }
    // 其他情况
    else {
      date = new Date(dateInput)
    }

    console.log('转换后的日期对象:', date)

    // 检查日期是否有效
    if (isNaN(date.getTime())) {
      console.log('日期无效，时间戳:', dateInput)
      return '无效日期'
    }

    // 使用 dateFormat 函数
    const formatted = dateFormat(date, 'yyyy-MM-dd')
    console.log('格式化结果:', formatted)
    return formatted

  } catch (error) {
    console.error('日期格式化错误:', error)
    // 回退方案：手动格式化
    try {
      const timestamp = typeof dateInput === 'number' ? dateInput : parseInt(dateInput)
      const date = new Date(timestamp)
      const year = date.getFullYear()
      const month = String(date.getMonth() + 1).padStart(2, '0')
      const day = String(date.getDate()).padStart(2, '0')
      return `${year}-${month}-${day}`
    } catch (e) {
      return '日期错误'
    }
  }
}

const formattedDate = computed(() => {
  return formatDate(props.article.created)
})
</script>

<template>
  <el-row>
    <el-col :sm="24" :md="11">
      <el-image :src="props.article.thumbnail" />
    </el-col>
    <el-col :sm="0" :md="1"></el-col>
    <el-col :sm="24" :md="12">
      <el-row align="middle">
        <el-space :size="size">
          <span id="categories" class="categories-height" v-html="props.article.categories"></span>
          <span class="categories-height">发布于 {{ formattedDate }}</span>
        </el-space>
      </el-row>
      <el-row align="middle">
        <router-link :to="{ name: 'articleAndComment', params: { articleId: props.article.id } }" class="title-link">
          <span class="title" v-html="props.article.title"></span>
        </router-link>
      </el-row>
      <el-row align="middle">
        <span v-html="props.article.content.substring(0, 90)"></span>
      </el-row>
    </el-col>
    <el-col :span="1"></el-col>
  </el-row>
  <el-divider />
</template>

<style scoped>
#categories:hover {
  color: #10007A;
}

.categories-height {
  line-height: 40px;
}

.title {
  color: #0f9ae0;
  font-size: 20px;
  line-height: 40px;
}

/* 去除链接默认下划线 */
.title-link {
  text-decoration: none;
}

/* 鼠标悬停时改变标题颜色 (参考了项目中其他链接的悬停颜色) */
.title-link:hover .title {
  color: #10007A;
  cursor: pointer;
}
</style>