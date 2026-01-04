<script setup>
import Top from '@/components/Top.vue'
import ArticleHeader from "@/components/ArticleHeader.vue";
import ReadRanking from '@/components/ReadRanking.vue'; // 修正引用路径
import { ElMessage } from 'element-plus';
import { reactive, inject, ref, computed } from 'vue'
import { onBeforeRouteLeave } from 'vue-router';
import { useStore } from '@/stores/my.js'
import imageMeUrl from '@/assets/me.jpg'
import { Loading } from '@element-plus/icons-vue' // 引入 Loading 图标

const store = useStore()
const size = ref(20)
const axios = inject('axios')
const toArticle = inject('toArticle')

// --- 状态控制 ---
const isImmersionMode = ref(false) // 是否开启沉浸模式
const loading = ref(false)
const noMore = ref(false)
const currentTag = ref('') // 当前选中的标签

const data = reactive({
  "articles": [],
  "rankingList": [],
  "tags": [], // 标签列表
  "pageParams": { "page": store.home.page || 1, "rows": 10, "total": 0 },
})

// --- 布局配置 (沉浸模式下内容变宽，侧边栏消失) ---
const contentLayout = computed(() => {
  if (isImmersionMode.value) {
    return { xs: 22, sm: 20, md: 18, lg: 16, xl: 14 }
  } else {
    return { xs: 22, sm: 22, md: 15, lg: 14, xl: 13 }
  }
})

const sidebarLayout = computed(() => {
  return { xs: 22, sm: 22, md: 7, lg: 7, xl: 6 }
})

// === 1. 初始化 ===
function init() {
  loading.value = true;
  // 获取首页数据 (轮播图+文章+排行榜)
  axios.post("/api/article/getIndexData1", data.pageParams).then(res => {
    loading.value = false;
    if (res.data.success) {
      data.articles = res.data.map.articles || [];
      data.rankingList = res.data.map.articleVOs || [];
      if (res.data.map.pageParams) {
        data.pageParams.total = res.data.map.pageParams.total;
      }
    } else {
      ElMessage.error("数据加载失败");
    }
  }).catch(e => {
    loading.value = false;
  });

  // 获取所有标签 (用于标签云)
  axios.get("/api/article/getAllTags").then(res => {
    if (res.data.success) {
      data.tags = res.data.map.tags || [];
    }
  });
}
init();

// === 2. 核心查询逻辑 (支持标签筛选) ===
function getAPage(isAppend = false) {
  if (!isAppend) {
    loading.value = true;
    // 如果是重新搜索，先清空列表，让用户知道正在刷新
    if (data.pageParams.page === 1) {
      data.articles = [];
    }
  }

  let url = '/api/article/getAPageOfArticle';
  // 关键：深拷贝参数，防止污染
  let postData = JSON.parse(JSON.stringify(data.pageParams));

  // 如果处于标签筛选模式，使用搜索接口
  if (currentTag.value) {
    url = '/api/article/articleSearch';
    // 构造后端需要的 ArticleSearch 结构
    postData = {
      pageParams: { ...data.pageParams },
      articleCondition: {
        tag: currentTag.value // 传入 tag 字段
      }
    }
  }

  axios.post(url, postData).then((response) => {
    loading.value = false;
    if (response.data.success) {
      // 兼容两种接口返回的数据结构
      const newArticles = response.data.map.articles || response.data.map.articleVOs || [];

      if (response.data.map.pageParams) {
        data.pageParams.total = response.data.map.pageParams.total;
      }

      // 没数据处理
      if (newArticles.length === 0) {
        noMore.value = true;
        if (!isAppend) {
          data.articles = [];
          if (currentTag.value) {
            ElMessage.warning(`标签【${currentTag.value}】下暂无文章`);
          }
        }
        return;
      }

      // 有数据处理
      if (isAppend) {
        data.articles.push(...newArticles) // 追加模式 (沉浸式)
      } else {
        data.articles = newArticles // 覆盖模式 (分页式)
        window.scrollTo(0, 0)
      }
    } else {
      ElMessage.error(response.data.msg || "请求失败")
    }
  }).catch((error) => {
    loading.value = false;
    console.error("请求错误:", error);
    ElMessage.error("网络或服务器异常");
  })
}

// === 3. 交互函数 ===

// 分页页码改变
function handleCurrentChange(newPage) {
  data.pageParams.page = newPage
  getAPage()
}

// 加载更多 (沉浸模式)
function loadMore() {
  if (loading.value || noMore.value) return;
  loading.value = true;
  setTimeout(() => {
    data.pageParams.page += 1;
    getAPage(true); // isAppend = true
  }, 500);
}

// 点击标签切换
function selectTag(tag) {
  const clickedTag = String(tag);

  // 如果点击的是当前选中的，或者是点"全部"，则取消筛选
  if (currentTag.value === clickedTag || clickedTag === '') {
    if (currentTag.value !== '') ElMessage.info("已显示全部文章");
    currentTag.value = '';
  } else {
    currentTag.value = clickedTag;
    ElMessage.success(`正在筛选: ${clickedTag}`);
  }

  // 重置查询状态
  data.pageParams.page = 1;
  noMore.value = false;
  loading.value = false;

  // 立即查询
  getAPage(false);
}

// 切换阅读模式
function handleModeSwitch(val) {
  data.pageParams.page = 1;
  noMore.value = false;

  if (val) {
    // 进入沉浸模式
    data.articles = [];
    loading.value = true;
    getAPage(true); // 初始加载
    ElMessage.success("进入沉浸阅读模式")
  } else {
    // 切回普通模式
    ElMessage.info("已切换回普通模式")
    if (!currentTag.value) {
      init(); // 重新初始化（包含轮播图等）
    } else {
      getAPage(false);
    }
  }
}

// 路由离开前记录页码
onBeforeRouteLeave((to, from) => {
  if (to.fullPath.indexOf("article_comment") >= 0) {
    store.home.page = data.pageParams.page
  } else {
    store.home.page = 1
  }
  return true
})

function toGithub() {
  window.open('https://github.com/Zzt147/-SpringBoot-Vue3-', '_blank')
}

const disabled = computed(() => loading.value || noMore.value)
</script>

<template>
  <el-affix>
    <Top />
  </el-affix>

  <el-row style="margin-top:40px" justify="center" :gutter="20">

    <el-col v-bind="contentLayout">
      <div class="tool-bar">
        <el-tag v-if="currentTag" closable type="warning" @close="selectTag(currentTag)"
          style="margin-right: auto; font-size: 14px; padding: 18px 10px;">
          当前标签: {{ currentTag }} (点击取消)
        </el-tag>

        <span class="mode-label">阅读模式：</span>
        <el-switch v-model="isImmersionMode" inline-prompt active-text="沉浸" inactive-text="分页"
          @change="handleModeSwitch" />
      </div>

      <div v-if="isImmersionMode" class="immersion-container" v-infinite-scroll="loadMore"
        :infinite-scroll-disabled="disabled" :infinite-scroll-immediate="false" infinite-scroll-distance="50">

        <div class="article-list-wrapper">
          <template v-for="article in data.articles" :key="article.id">
            <ArticleHeader :article="article" />
          </template>
        </div>

        <div class="loading-state">
          <p v-if="loading">
            <el-icon class="is-loading">
              <Loading />
            </el-icon> 正在加载...
          </p>
          <p v-if="noMore && data.articles.length > 0">——— 到底啦 ———</p>
          <p v-if="noMore && data.articles.length === 0">——— 暂无相关文章 ———</p>
        </div>
      </div>

      <div v-else class="article-list-wrapper">
        <template v-for="article in data.articles" :key="article.id">
          <ArticleHeader :article="article" />
        </template>
        <el-empty v-if="data.articles.length === 0 && !loading" description="暂无相关文章" />
      </div>

      <div v-if="!isImmersionMode && data.articles.length > 0" class="pagination-container">
        <el-pagination v-model:currentPage="data.pageParams.page" v-model:page-size="data.pageParams.rows"
          layout="prev, pager, next" :total="data.pageParams.total" @current-change="handleCurrentChange"
          :pager-count="7" />
      </div>
    </el-col>

    <el-col v-if="!isImmersionMode" v-bind="sidebarLayout">
      <fieldset align="center">
        <legend>
          <h3>个人信息</h3>
        </legend>
        <el-image :src="imageMeUrl" style="width: 100px; height: 100px; border-radius: 50%;" />
        <div style="margin-top:16px;">Java后台开发</div>
        <div style="margin-top:16px; font-size: 13px; color: #666;">
          (并非)博客小站，主要发表关于Java、Spring、Docker等相关文章
        </div>
      </fieldset>

      <fieldset align="left" class="tag-fieldset">
        <legend>
          <h3>标签云</h3>
        </legend>
        <div class="tag-cloud">
          <el-tag class="tag-item" :type="currentTag === '' ? 'primary' : 'info'"
            :effect="currentTag === '' ? 'dark' : 'plain'" @click="selectTag('')">
            全部
          </el-tag>

          <el-tag v-for="tag in data.tags" :key="tag" class="tag-item" :type="currentTag === tag ? 'warning' : 'info'"
            :effect="currentTag === tag ? 'dark' : 'plain'" @click="selectTag(tag)">
            {{ tag }}
          </el-tag>

          <div v-if="data.tags.length === 0" style="color:#999; font-size:13px; text-align: center; width: 100%;">
            暂无标签
          </div>
        </div>
      </fieldset>

      <fieldset align="center">
        <legend>
          <h3>联系我</h3>
        </legend>
        <el-space :size="size">
          <font-awesome-icon class="icon" :icon="['fab', 'github']" size="lg" border @click="toGithub" />
          <font-awesome-icon class="icon" :icon="['fab', 'weibo']" size="lg" border />
        </el-space>
      </fieldset>

      <fieldset align="left">
        <legend>
          <h3>阅读排行榜</h3>
        </legend>
        <ReadRanking :articleVOs="data.rankingList" />
      </fieldset>
    </el-col>

  </el-row>
</template>

<style scoped>
.icon:hover {
  color: #10D07A;
  cursor: pointer;
}

fieldset {
  border-color: #eee;
  border-width: 1px;
  border-style: solid;
  margin-bottom: 20px;
  background: #fff;
  border-radius: 4px;
  padding: 15px;
}

/* 标签云样式优化 */
.tag-cloud {
  display: flex;
  flex-wrap: wrap;
  gap: 10px;
  justify-content: flex-start;
}

.tag-item {
  cursor: pointer;
  transition: all 0.3s;
  border: none;
  font-size: 13px;
}

.tag-item:hover {
  transform: translateY(-2px);
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}

.tool-bar {
  display: flex;
  align-items: center;
  justify-content: flex-end;
  margin-bottom: 15px;
  padding-right: 5px;
  min-height: 40px;
}

.mode-label {
  font-size: 14px;
  color: #666;
  margin-right: 10px;
}

.loading-state {
  text-align: center;
  padding: 30px 0;
  color: #999;
  font-size: 14px;
}

.pagination-container {
  margin-top: 20px;
  display: flex;
  justify-content: center;
}
</style>