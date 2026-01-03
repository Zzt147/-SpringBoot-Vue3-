<script setup>
import { ref, reactive, inject, onMounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { Plus, Edit, Delete, Rank, Folder, FolderOpened } from '@element-plus/icons-vue'

const axios = inject('axios')
const treeData = ref([])
const loading = ref(false)

// 【新增】定义树形控件的字段映射：将 label 映射为 name
const defaultProps = {
  children: 'children',
  label: 'name'
}

// === 1. 获取数据 ===
function loadTree() {
  loading.value = true
  axios.get('/api/category/getTree').then(res => {
    if (res.data.success) {
      treeData.value = res.data.map.data || []
    }
    loading.value = false
  })
}

onMounted(() => {
  loadTree()
})

// === 2. 增删改逻辑 ===
const dialogVisible = ref(false)
const dialogTitle = ref('')
const formRef = ref(null)
const formData = reactive({
  id: null,
  name: '',
  parentId: 0,
  sort: 0
})
const rules = {
  name: [{ required: true, message: '请输入分类名称', trigger: 'blur' }]
}

// 打开新增/编辑弹窗
function openDialog(type, nodeData) {
  dialogVisible.value = true
  // 重置表单
  formData.id = null
  formData.name = ''
  formData.sort = 0

  if (type === 'add_root') {
    dialogTitle.value = '新增顶级分类'
    formData.parentId = 0
  } else if (type === 'add_sub') {
    dialogTitle.value = `在 [${nodeData.name}] 下新增子分类`
    formData.parentId = nodeData.id
  } else if (type === 'edit') {
    dialogTitle.value = '编辑分类'
    formData.id = nodeData.id
    formData.name = nodeData.name
    formData.parentId = nodeData.parentId
    formData.sort = nodeData.sort
  }
}

// 提交表单
function submitForm() {
  formRef.value.validate((valid) => {
    if (valid) {
      const url = formData.id ? '/api/category/update' : '/api/category/add'
      axios.post(url, formData).then(res => {
        if (res.data.success) {
          ElMessage.success(res.data.msg)
          dialogVisible.value = false
          loadTree() // 刷新树
        } else {
          ElMessage.error(res.data.msg)
        }
      })
    }
  })
}

// 删除分类
function remove(node, data) {
  ElMessageBox.confirm(`确定删除分类 [${data.name}] 吗?`, '警告', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning',
  }).then(() => {
    axios.post('/api/category/delete?id=' + data.id).then(res => {
      if (res.data.success) {
        ElMessage.success('删除成功')
        loadTree()
      } else {
        ElMessage.error(res.data.msg)
      }
    })
  })
}

// === 3. 拖拽排序核心逻辑 ===
const handleDrop = (draggingNode, dropNode, dropType, ev) => {
  // dropType: 'before', 'after', 'inner'
  // 1. 确定新的 parentId
  let newParentId = 0
  if (dropType === 'inner') {
    newParentId = dropNode.data.id
  } else {
    newParentId = dropNode.data.parentId
  }

  // 2. 获取受影响的同级节点列表（用于重排 sort）
  // 此时 el-tree 的数据结构已经更新了，我们只需要遍历 dropNode 的父节点的 children
  const parentNode = dropType === 'inner' ? dropNode : dropNode.parent
  const siblings = parentNode.level === 0 ? treeData.value : parentNode.data.children || []

  // 3. 构建批量更新的数据
  const updateList = siblings.map((item, index) => {
    return {
      id: item.id,
      parentId: newParentId, // 确保 parentId 正确
      name: item.name,       // 名字保持不变
      sort: index + 1        // 根据数组下标重置 sort (1, 2, 3...)
    }
  })

  // 4. 发送给后端保存
  axios.post('/api/category/updateBatch', updateList).then(res => {
    if (!res.data.success) {
      ElMessage.error('排序保存失败，请刷新重试')
      loadTree() // 回滚
    } else {
      ElMessage.success('排序已更新')
    }
  })
}

// 仅允许同级拖拽或拖入文件夹 (可选限制)
// function allowDrop(draggingNode, dropNode, type) { ... }
</script>

<template>
  <div class="category-manage">
    <el-card shadow="always">
      <template #header>
        <div class="card-header">
          <span>🏷️ 分类与标签管理</span>
          <el-button type="primary" :icon="Plus" @click="openDialog('add_root')">新建顶级分类</el-button>
        </div>
      </template>

      <el-alert title="提示：支持拖拽节点来改变层级和排序，操作后会自动保存。" type="info" show-icon style="margin-bottom: 20px;"
        :closable="false" />

      <div class="custom-tree-container">
        <el-tree v-loading="loading" :data="treeData" node-key="id" default-expand-all draggable :allow-drop="allowDrop"
          @node-drop="handleDrop" :expand-on-click-node="false" :indent="30" :props="defaultProps">
          <template #default="{ data }">
            <div class="custom-tree-node">
              <span class="node-label">
                <el-icon class="icon-folder" v-if="data.children && data.children.length > 0">
                  <FolderOpened />
                </el-icon>
                <el-icon class="icon-folder" v-else>
                  <Folder />
                </el-icon>
                {{ data.name }}
              </span>

            </div>
          </template>
        </el-tree>
      </div>
    </el-card>

    <el-dialog v-model="dialogVisible" :title="dialogTitle" width="400px">
      <el-form :model="formData" :rules="rules" ref="formRef" label-width="80px">
        <el-form-item label="分类名称" prop="name">
          <el-input v-model="formData.name" placeholder="请输入分类名称" />
        </el-form-item>
        <el-form-item label="排序值" prop="sort">
          <el-input-number v-model="formData.sort" :min="0" />
          <span style="margin-left: 10px; color: #999; font-size: 12px;">(越小越靠前)</span>
        </el-form-item>
      </el-form>
      <template #footer>
        <span class="dialog-footer">
          <el-button @click="dialogVisible = false">取消</el-button>
          <el-button type="primary" @click="submitForm">确定</el-button>
        </span>
      </template>
    </el-dialog>
  </div>
</template>

<style scoped>
.category-manage {
  padding: 20px;
}

.card-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
}

.custom-tree-container {
  max-width: 800px;
  margin: 0 auto;
  /* 居中显示 */
  border: 1px solid #eee;
  padding: 20px;
  border-radius: 8px;
}

.custom-tree-node {
  flex: 1;
  display: flex;
  align-items: center;
  justify-content: space-between;
  font-size: 14px;
  padding-right: 8px;
}

.node-label {
  display: flex;
  align-items: center;
  font-weight: 500;
}

.node-label .icon {
  margin-right: 6px;
  color: #E6A23C;
  /* 文件夹颜色 */
}

.node-actions {
  opacity: 0;
  /* 默认隐藏按钮 */
  transition: opacity 0.2s;
}

.custom-tree-node:hover .node-actions {
  opacity: 1;
  /* 鼠标悬停显示按钮 */
}

/* 调整树节点高度 */
:deep(.el-tree-node__content) {
  height: 40px;
  border-bottom: 1px dashed #f5f7fa;
}

:deep(.el-button+.el-button) {
  margin-left: 8px;
}
</style>