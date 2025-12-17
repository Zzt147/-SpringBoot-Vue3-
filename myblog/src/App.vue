<script setup>
import { RouterView, useRouter } from 'vue-router'
import { provide } from 'vue'

const router = useRouter()

router.push({ name: 'home' })

const toHome = () => {
  router.push({ name: 'home' })
}

const toLogin = () => {
  router.push({ name: 'login' })
}

const toAdminMain = () => {
  router.push({ name: 'adminMain' })
}

function toArticle() {
  router.push({ name: 'articleAndComment', params: { articleId: 20 } })
}
provide('toAdminMain', toAdminMain)
provide('toArticle', toArticle)
provide('toHome', toHome)
provide('toLogin', toLogin)
</script>

<template>
  <RouterView />
</template>

<style scoped></style>