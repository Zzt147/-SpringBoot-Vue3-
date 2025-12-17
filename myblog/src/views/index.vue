<script setup>
import Top from '@/components/Top.vue'
import ArticleHeader from "@/components/ArticleHeader.vue";
import ReadRanking from '../components/ReadRanking.vue';
import { ElMessageBox } from 'element-plus';
import { reactive, inject, ref } from 'vue'
import { onBeforeRouteLeave } from 'vue-router';
import { useStore } from '@/stores/my.js'
const store = useStore()
import imageMeUrl from '@/assets/me.jpg'
const size = ref(20)

const axios = inject('axios')

const data = reactive({
  "articles": [],
  "pageParams": { "page": store.home.page, "rows": 5, "total": 0 },
  "articleVOs": [],
})

function getIndexData() {
  axios({
    method: "post",
    url: "/api/article/getIndexData1",
    data: data.pageParams
  })
    .then((response) => {
      if (response.data.success) {
        data.articles = response.data.map.articles
        data.articleVOs = response.data.map.articleVOs
        data.pageParams = response.data.map.pageParams
        // 如果后端返回了分页信息，我们也可以更新
        if (response.data.map.pageParams) {
          data.pageParams = response.data.map.pageParams
        }
      } else {
        ElMessageBox.alert(response.data.msg, '结果')
      }
    }).catch((error) => {
      ElMessageBox.alert("系统错误！", '结果')
    })
}

getIndexData()
const toArticle = inject('toArticle')

function getAPage() { // 分页查询文章
  axios({
    method: 'post',
    url: '/api/article/getAPageOfArticle',
    data: data.pageParams
  }).then((response) => {
    if (response.data.success) {
      if (response.data.map.articles != null) {
        data.articles = response.data.map.articles
        data.pageParams = response.data.map.pageParams
        window.scrollTo(0, 0) // 滚动到顶端
      } else {
        ElMessageBox.alert("无文章！", '结果')
      }
    } else {
      ElMessageBox.alert(response.data.msg, '结果')
    }
  }).catch((error) => { // 请求失败返回的数据
    ElMessageBox.alert("系统错误！", '结果')
  })
}

onBeforeRouteLeave((to, from) => {
  if (to.fullPath.indexOf("article_comment") >= 0) {
    store.home.page = data.pageParams.page
  } else {
    store.home.page = 1
  }
  // 如果离开此vue去新闻详情页面，则记录当前vue的页码，否则不记录。
  // 如果点击"后台管理"，然后再回到主页，主页中分页组件只会显示到第1页，而不会回到主页之前的页码状态。
  return true
})

function handleCurrentChange(newPage) {
  data.pageParams.page = newPage
  getIndexData() // 或者调用其他获取分页数据的方法
}
</script>

<template>
  <el-affix>
    <Top />
  </el-affix>
  <el-row style="margin-top:40px" align="top">
    <el-col :span="1"></el-col>
    <el-col :span="14">
      <el-row>
        <el-col>
          <template v-for="article in data.articles" :key="article.id">
            <ArticleHeader :article="article" />
          </template>
        </el-col>
      </el-row>
      <el-row>
        <el-col>
          <el-pagination v-model:currentPage="data.pageParams.page" v-model:page-size="data.pageParams.rows"
            layout="prev, pager, next" :total="data.pageParams.total" @current-change="handleCurrentChange"
            :pager-count="7" />
        </el-col>
      </el-row>
    </el-col>
    <el-col :span="1"></el-col>
    <el-col :span="7">
      <fieldset align="center">
        <legend>
          <h3>CrazyStone</h3>
        </legend>
        <el-image :src="imageMeUrl" />
        <div style="margin-top:16px;">Java后台开发</div>
        <div style="margin-top:16px;">
          个人博客小站，主要发表关于Java、Spring、Docker等相关文章
        </div>
      </fieldset>


      <fieldset align="center">
        <legend>
          <h3>联系我</h3>
        </legend>
        <el-space :size="size">
          <font-awesome-icon class="icon" :icon="['fab', 'github']" size="lg" border />
          <font-awesome-icon class="icon" :icon="['fab', 'weibo']" size="lg" border />
        </el-space>
      </fieldset>

      <fieldset align="left">
        <legend>
          <h3>阅读排行榜</h3>
        </legend>
        <!-- 添加阅读排行榜 -->
        <ReadRanking :articleVOs="data.articleVOs" />
      </fieldset>

    </el-col>
    <el-col :span="1"></el-col>
  </el-row>
</template>

<style scoped>
.icon:hover {
  color: #10D07A;
}

fieldset {
  border-color: #eee;
  border-width: 1px;
  border-style: solid;
  margin-bottom: 20px;
  /* 添加底部间距 */
}
</style>