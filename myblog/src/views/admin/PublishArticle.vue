<script setup>
import { reactive, ref, inject, provide, nextTick, onMounted } from 'vue'
import Editor from '@tinymce/tinymce-vue'
import { ElMessageBox } from 'element-plus'
import { useStore } from '@/stores/my'
import Cropper from "@/components/Cropper.vue";
import { undefine, nullZeroBlank } from "@/js/tool.js"

const store = useStore()
let type = "add"
const header = ref("发布文章")
const axios = inject('axios')

// === 新增：分类树数据 ===
const categoryOptions = ref([])
const selectedCategory = ref([]) // 绑定的级联选择数组 ['技术', '后端', 'Java']

// 图片上传处理
const image_upload_handler = (blobInfo, progress) => new Promise((resolve, reject) => {
  const xhr = new XMLHttpRequest();
  xhr.withCredentials = false;
  xhr.open('POST', '/api/article/upload');
  xhr.upload.onprogress = (e) => { progress(e.loaded / e.total * 100); };
  xhr.onload = () => {
    if (xhr.status === 403) { reject({ message: 'HTTP Error: ' + xhr.status, remove: true }); return; }
    if (xhr.status < 200 || xhr.status >= 300) { reject('HTTP Error: ' + xhr.status); return; }
    const json = JSON.parse(xhr.response);
    if (!json || !json.map || typeof json.map.url != 'string') { reject('Invalid JSON: ' + xhr.responseText); return; }
    resolve(json.map.url);
  };
  xhr.onerror = () => { reject('Image upload failed. Code: ' + xhr.status); };
  const formData = new FormData();
  formData.append('file', blobInfo.blob(), blobInfo.filename());
  xhr.send(formData);
});

const apiKey = ref('bdddx89zynvfw2qmzfk2mhycdiss6ujej1hkf49al3p0omcc')
const init = reactive({
  language: "zh_CN",
  placeholder: "在这里输入文字",
  plugins: ['image', 'code'],
  toolbar: 'image',
  images_file_types: 'jpg,jpeg,png,gif,bmp',
  images_upload_handler: image_upload_handler,
  convert_urls: false
})

// === 修改：初始化文章对象，增加 categories ===
let article = reactive({ "title": "", "tags": "", "content": "", "categories": "", "thumbnail": "" })

// === 新增：加载分类树 ===
function loadCategoryTree() {
  axios.get('/api/category/getTree').then(res => {
    if (res.data.success) {
      categoryOptions.value = res.data.map.data // 注意：后端返回的数据在 map.data 中
    }
  })
}

// 初始化加载
onMounted(() => {
  loadCategoryTree()

  if (store.articleId > 0) {
    type = "edit"
    header.value = "编辑文章"
    axios({
      method: 'post',
      url: '/api/article/selectById?id=' + store.articleId
    }).then((response) => {
      if (response.data.success) {
        let nowArticle = response.data.map.article
        article.id = nowArticle.id
        article.title = nowArticle.title
        article.tags = nowArticle.tags
        article.content = nowArticle.content
        article.thumbnail = nowArticle.thumbnail

        // 回显分类：将存储的字符串 "技术/后端/Java" 转回数组
        if (nowArticle.categories) {
          article.categories = nowArticle.categories
          selectedCategory.value = nowArticle.categories.split('/')
        }

        if (!undefine(article.thumbnail) && !nullZeroBlank(article.thumbnail) && article.thumbnail.indexOf("/api") == 0) {
          cropper1.value.setThumbnail(article.thumbnail)
        }
      } else {
        ElMessageBox.alert(response.data.msg, '结果')
      }
      store.articleId = 0
    }).catch((error) => {
      ElMessageBox.alert("系统错误！", '结果')
      store.articleId = 0
    })
  }
})

const cropper1 = ref(null)

function publishArticle() {
  let thumbnail = cropper1.value.getThumbnail()
  if (undefine(thumbnail) || nullZeroBlank(thumbnail) || thumbnail.indexOf("/api") != 0) {
    article.thumbnail = ""
  } else {
    article.thumbnail = thumbnail
  }

  // === 新增：处理分类 ===
  // 将级联选择的数组 ['技术', '后端', 'Java'] 拼接成字符串 "技术/后端/Java" 存入数据库
  if (selectedCategory.value && selectedCategory.value.length > 0) {
    article.categories = selectedCategory.value.join('/')
  } else {
    article.categories = "默认分类"
  }

  // === 新增：处理标签格式 ===
  // 自动将用户输入的 "Java SpringBoot" 转换为 "#Java #SpringBoot"
  if (article.tags) {
    // 1. 替换中文逗号、英文逗号为为空格
    let tempTags = article.tags.replace(/，/g, ' ').replace(/,/g, ' ').trim()
    // 2. 按空格分割
    let tagList = tempTags.split(/\s+/)
    // 3. 确保每个标签以 # 开头
    article.tags = tagList.map(tag => tag.startsWith('#') ? tag : '#' + tag).join(' ')
  }

  axios({
    method: 'post',
    url: '/api/article/publishArticle?type=' + type,
    data: article,
    timeout: 3000000
  }).then((response) => {
    ElMessageBox.alert(response.data, '结果')
    if ("添加成功！" == response.data) {
      clearData()
      window.scrollTo(0, 0)
    }
  }).catch((error) => {
    ElMessageBox.alert("系统错误！", '结果')
  })
}

const gotoArticleManage = inject("gotoArticleManage")
let isShowCropper = ref(true)

function freshCropper() {
  isShowCropper.value = false
  nextTick(() => { isShowCropper.value = true; })
}
provide("freshCropper", freshCropper)

function clearData() {
  article.title = ""
  article.tags = ""
  article.content = ""
  article.categories = "" // 清空分类
  selectedCategory.value = [] // 清空选择器
  article.thumbnail = ""
  cropper1.value.clearData()
}
</script>

<template>
  <el-row>
    <el-col :span="24">
      <h4>{{ header }}</h4>
    </el-col>
  </el-row>

  <el-row :gutter="20" style="margin-bottom: 20px;">
    <el-col :span="8">
      <el-input v-model="article.title" placeholder="请输入文章标题（必须）" clearable />
    </el-col>

    <el-col :span="8">
      <el-cascader v-model="selectedCategory" :options="categoryOptions"
        :props="{ checkStrictly: true, value: 'name', label: 'name' }" placeholder="请选择文章分类" clearable
        style="width: 100%;" />
    </el-col>

    <el-col :span="8">
      <el-input v-model="article.tags" placeholder="标签: #Java #Spring (空格隔开)" clearable />
    </el-col>
  </el-row>

  <el-row>
    <el-col :span="24">
      <div id="editor">
        <editor v-model="article.content" :init="init" :api-key="apiKey" />
      </div>
    </el-col>
  </el-row>
  <el-row>
    <el-col :span="24">
      <Cropper ref="cropper1" v-if="isShowCropper" />
    </el-col>
  </el-row>
  <el-row>
    <el-col :span="24">
      <div align="right">
        <el-button @click="gotoArticleManage">返回列表</el-button>
        <el-button type="primary" @click="publishArticle">保存文章</el-button>
      </div>
    </el-col>
  </el-row>
</template>

<style scoped></style>