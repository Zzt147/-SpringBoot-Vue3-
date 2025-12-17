<script setup>
import { reactive, inject, ref } from 'vue'
import { ElMessage } from 'element-plus'
import { Delete, Back, Document } from '@element-plus/icons-vue'

const axios = inject('axios')

// 数据状态
let myData = reactive({
  "comments": [],
  "pageParams": { "page": 1, "rows": 10, "total": 0 },
  "isFilterMode": false, // 是否处于筛选模式
  "filterAuthor": ""     // 当前筛选的用户名
})

// ==========================================
// 【核心修复】数据标准化适配器
// 仿照父页面的数据格式，修正子页面的字段名差异
// ==========================================
function fixData(commentList) {
  if (!commentList || !Array.isArray(commentList)) {
    return []
  }

  return commentList.map(item => {
    // 1. 修正文章ID (如果后端返回了 article_id 但没返回 articleId)
    if (!item.articleId && item.article_id) {
      item.articleId = item.article_id
    }

    // 2. 修正文章标题 (如果后端返回了 title 但没返回 targetName)
    if (!item.targetName && item.title) {
      item.targetName = item.title
    }

    // 3. 修正文章标题 (有时候可能叫 articleTitle)
    if (!item.targetName && item.articleTitle) {
      item.targetName = item.articleTitle
    }

    return item
  })
}

// 1. 获取管理员分页评论列表 (默认模式 - 父页面)
function getAPage() {
  myData.isFilterMode = false
  myData.filterAuthor = ""

  axios.post('/api/comment/getAdminPage', myData.pageParams)
    .then((response) => {
      if (response.data.success) {
        // 虽然父页面通常是正常的，但也加上 fixData 以防万一
        myData.comments = fixData(response.data.map.comments || [])

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

// 2. 获取某用户的所有评论 (筛选模式 - 发布人子页面)
function getUserComments(author) {
  myData.isFilterMode = true
  myData.filterAuthor = author

  axios.post('/api/comment/getUserComments?author=' + author)
    .then(res => {
      if (res.data.success) {
        // 【关键修复在这里】
        // 使用 fixData 函数处理后端返回的数据，确保 articleId 和 targetName 存在
        myData.comments = fixData(res.data.map.comments || [])

        myData.pageParams.total = myData.comments.length
        myData.pageParams.page = 1
      } else {
        ElMessage.warning(res.data.msg)
      }
    })
    .catch(() => ElMessage.error("获取用户评论失败"))
}

// 初始化加载
getAPage()

// 分页改变处理
function handleSizeChange(newRows) {
  if (myData.isFilterMode) return
  myData.pageParams.rows = newRows
  myData.pageParams.page = 1
  getAPage()
}

function handleCurrentChange(newPage) {
  if (myData.isFilterMode) return
  myData.pageParams.page = newPage
  getAPage()
}

// 删除逻辑
const dialogVisible = ref(false)
let deleteTarget = reactive({ id: 0, type: 'COMMENT' })

function showDeleteDialog(row) {
  deleteTarget.id = row.id
  deleteTarget.type = row.type || 'COMMENT'
  dialogVisible.value = true
}

function confirmDelete() {
  let url = '/api/comment/deleteById?id=' + deleteTarget.id
  if (deleteTarget.type === 'REPLY') {
    url = '/api/reply/deleteById?id=' + deleteTarget.id
  }

  axios.post(url)
    .then((response) => {
      if (response.data.success) {
        ElMessage.success("删除成功")
        dialogVisible.value = false
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

              <router-link v-if="scope.row.articleId"
                :to="{ name: 'articleAndComment', params: { articleId: scope.row.articleId } }" class="content-link"
                title="点击前往文章详情">
                {{ scope.row.content }}
              </router-link>

              <span v-else>{{ scope.row.content }}</span>
            </div>
          </template>
        </el-table-column>

        <el-table-column label="发布人" width="130" align="center">
          <template #default="scope">
            <span class="author-link" @click="getUserComments(scope.row.author)" title="点击筛选该用户">
              {{ scope.row.author }}
            </span>
          </template>
        </el-table-column>

        <el-table-column label="所属文章" width="220" :show-overflow-tooltip="true">
          <template #default="scope">
            <router-link v-if="scope.row.articleId"
              :to="{ name: 'articleAndComment', params: { articleId: scope.row.articleId } }"
              style="text-decoration: none; color: #606266; font-size: 13px; display: flex; align-items: center;">
              <el-icon style="margin-right: 4px;">
                <Document />
              </el-icon>
              {{ scope.row.targetName ? `《${scope.row.targetName}》` : ('文章ID: ' + scope.row.articleId) }}
            </router-link>
            <span v-else>无关联文章</span>
          </template>
        </el-table-column>

        <el-table-column prop="created" label="发布时间" width="160" align="center" />

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
.content-link {
  text-decoration: none;
  color: #606266;
  transition: color 0.2s;
  overflow: hidden;
  text-overflow: ellipsis;
  display: -webkit-box;
  -webkit-line-clamp: 2;
  -webkit-box-orient: vertical;
}

.content-link:hover {
  color: #409EFF;
  text-decoration: underline;
  cursor: pointer;
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