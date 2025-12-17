import { fileURLToPath, URL } from 'node:url'

import { defineConfig } from 'vite'
import vue from '@vitejs/plugin-vue'
import vueDevTools from 'vite-plugin-vue-devtools'

// https://vite.dev/config/
export default defineConfig({
  plugins: [vue(), vueDevTools()],
  resolve: {
    alias: {
      '@': fileURLToPath(new URL('./src', import.meta.url)),
    },
  },
  server: {
    //服务器
    proxy: {
      //反向代理
      '/api': {
        //要跨域的域名 目标地址：后端服务器网址
        target: 'http://localhost:8080',
        changeOrigin: true, //是否开启跨域，是否更改源路径
        ws: true, //代理websocked
        //将请求网址中的api替换为空''
        rewrite: (path) => path.replace(/^\/api/, ''),
      },
    },
  },
})
