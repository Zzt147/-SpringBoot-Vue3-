<script setup>
import { ref, inject } from 'vue'
import { useStore } from '@/stores/my'
import { ElMessageBox } from 'element-plus'
import { Search } from '@element-plus/icons-vue'
import { useRouter } from 'vue-router'

const size = ref(30)
const router = useRouter()
const store = useStore()
const axios = inject('axios')
const toLogin = inject("toLogin")  // 注意：这里应该是toLogin，不是tologin
const toHome = inject("toHome")

const userName = ref("")
const isLogined = ref(false)

// 检查是否已登录
if (store.user.user != null) {  // 如果是已登录，显示用户名称
  userName.value = "hi " + store.user.user.username
  isLogined.value = true  // 控制登录、退出的显示
}

function toExit() {  // 退出登录
  axios({
    method: 'post',
    url: '/api/logout'  // 要与Security设置的退出网址一致
  }).then((response) => {
    ElMessageBox.alert(response.data.msg, '结果')
    store.user.user = null  // 清除状态user
    isLogined.value = false
    userName.value = ""
    toHome()
  }).catch((error) => {  // 请求失败返回的数据
    ElMessageBox.alert("系统错误！", '结果')
  })
}

// 跳转到登录页面
function goToLogin() {
  if (toLogin) {
    toLogin()
  } else {
    router.push('/login')
  }
}
const toAdminMain = inject('toAdminMain')
</script>

<template>
  <el-row class="top" align="middle">
    <el-col :span="3"></el-col>
    <el-col :span="12">
      <a @click="toHome">CrazyStone个人博客小站</a>
    </el-col>
    <el-col :span="6">
      <el-space :size="size">
        <a @click="goToLogin" v-if="!isLogined">登录</a>
        <a @click="toAdminMain">后台管理</a>
        <a @click="toExit" v-if="isLogined">退出</a>
        <span v-html="userName"></span>
        <router-link title="查询" :to="{ path: '/search' }" style="text-decoration: none;">
          <el-icon>
            <Search class="searchIcon" />
          </el-icon>
        </router-link>
      </el-space>
    </el-col>
    <el-col :span="3"></el-col>
  </el-row>
</template>

<style scoped>
* {
  background: #5f9ea0;
  color: #fff;
  font-size: 22px;
}

.top {
  height: 80px;
}

a {
  text-decoration: none;
  cursor: pointer;
}

a:hover {
  color: #10007A;
}

.searchIcon {
  color: black;
}

.searchIcon:hover {
  color: #10007A;
}
</style>