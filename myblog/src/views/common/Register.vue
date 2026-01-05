<template>
  <div class="register-container">
    <el-row justify="center">
      <el-col :span="10">
        <h1 class="register-title">用户注册</h1>
      </el-col>
    </el-row>
    <el-row justify="center">
      <el-col :span="8">
        <el-form ref="registerFormRef" :model="registerForm" :rules="registerRules" :size="formSize"
          label-width="120px">

          <el-form-item label="用户名：" prop="username">
            <el-input v-model="registerForm.username" placeholder="请输入用户名" name="username" autocomplete="username">
              <template #prefix>
                <el-icon>
                  <User />
                </el-icon>
              </template>
            </el-input>
          </el-form-item>

          <el-form-item label="邮箱：" prop="email">
            <el-input v-model="registerForm.email" placeholder="请输入邮箱" name="email" autocomplete="email">
              <template #prefix>
                <el-icon>
                  <Message />
                </el-icon>
              </template>
            </el-input>
          </el-form-item>

          <el-form-item label="验证码：" prop="code">
            <el-row :gutter="10" style="width: 100%">
              <el-col :span="16">
                <el-input v-model="registerForm.code" placeholder="6位验证码" name="code" autocomplete="off">
                  <template #prefix>
                    <el-icon>
                      <Key />
                    </el-icon>
                  </template>
                </el-input>
              </el-col>
              <el-col :span="8">
                <el-button type="primary" :disabled="isSending || countdown > 0" @click="sendCode" style="width: 100%">
                  {{ countdown > 0 ? `${countdown}s后重发` : '发送验证码' }}
                </el-button>
              </el-col>
            </el-row>
          </el-form-item>

          <el-form-item label="密码：" prop="password">
            <el-input v-model="registerForm.password" type="password" show-password placeholder="请输入密码"
              autocomplete="new-password">
              <template #prefix>
                <el-icon>
                  <Lock />
                </el-icon>
              </template>
            </el-input>
          </el-form-item>

          <el-form-item label="确认密码：" prop="confirmPassword">
            <el-input v-model="registerForm.confirmPassword" type="password" show-password placeholder="请再次输入密码"
              autocomplete="new-password">
              <template #prefix>
                <el-icon>
                  <Lock />
                </el-icon>
              </template>
            </el-input>
          </el-form-item>

          <el-form-item>
            <el-button type="primary" @click="submitRegister(registerFormRef)">注册</el-button>
            <el-button @click="goToLogin">返回登录</el-button>
          </el-form-item>
        </el-form>
      </el-col>
    </el-row>
    <el-row justify="center">
      <el-col :span="8">
        <p style="margin-top: 20px; color: #666">
          已有账号？<el-link type="primary" @click="goToLogin">立即登录</el-link>
        </p>
      </el-col>
    </el-row>
  </div>
</template>

<script setup>
import { reactive, ref, onUnmounted } from 'vue'
import { ElMessage, ElMessageBox } from 'element-plus'
import { useRouter } from 'vue-router'
// 引入图标，让界面更清晰，不会混淆
import { User, Message, Lock, Key } from '@element-plus/icons-vue'
import axios from 'axios'

const router = useRouter()
const formSize = ref('default')
const registerFormRef = ref()

// === 发送验证码相关状态 ===
const isSending = ref(false)
const countdown = ref(0)
let timer = null

// 注册表单数据：现在包含了 code 字段
const registerForm = reactive({
  username: '',
  email: '',
  code: '',     // ✅ 新增
  password: '',
  confirmPassword: ''
})

// === 验证规则函数 ===
const validatePassword = (rule, value, callback) => {
  if (value === '') {
    callback(new Error('请输入密码'))
  } else if (value.length < 6) {
    callback(new Error('密码长度不能小于6位'))
  } else {
    callback()
  }
}

const validateConfirmPassword = (rule, value, callback) => {
  if (value === '') {
    callback(new Error('请再次输入密码'))
  } else if (value !== registerForm.password) {
    callback(new Error('两次输入密码不一致'))
  } else {
    callback()
  }
}

// 验证码校验
const validateCode = (rule, value, callback) => {
  if (value === '') {
    callback(new Error('请输入验证码'))
  } else if (!/^\d{6}$/.test(value)) {
    callback(new Error('验证码必须为6位数字'))
  } else {
    callback()
  }
}

// === 表单验证规则 ===
const registerRules = reactive({
  username: [
    { required: true, message: '请输入用户名', trigger: 'blur' },
    { min: 3, max: 20, message: '用户名长度在3到20个字符', trigger: 'blur' }
  ],
  email: [
    { required: true, message: '请输入邮箱地址', trigger: 'blur' },
    { type: 'email', message: '请输入正确的邮箱地址', trigger: ['blur', 'change'] }
  ],
  code: [ // ✅ 新增验证码规则
    { required: true, validator: validateCode, trigger: 'blur' }
  ],
  password: [
    { required: true, validator: validatePassword, trigger: 'blur' }
  ],
  confirmPassword: [
    { required: true, validator: validateConfirmPassword, trigger: 'blur' }
  ]
})

// === 发送验证码逻辑 ===
const sendCode = async () => {
  // 1. 先校验邮箱
  if (!registerForm.email) {
    ElMessage.warning('请先输入邮箱')
    return
  }
  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/
  if (!emailRegex.test(registerForm.email)) {
    ElMessage.warning('请输入有效的邮箱地址')
    return
  }

  // 2. 防止重复点击
  if (isSending.value) return
  isSending.value = true

  try {
    // 3. 发送请求
    const response = await axios.post('/api/user/sendEmailCode?email=' + registerForm.email)

    if (response.data.success) {
      ElMessage.success('验证码已发送，请查收')

      // 4. 开启倒计时
      countdown.value = 60
      if (timer) clearInterval(timer)

      timer = setInterval(() => {
        countdown.value--
        if (countdown.value <= 0) {
          clearInterval(timer)
          isSending.value = false
          countdown.value = 0
        }
      }, 1000)
    } else {
      ElMessage.error(response.data.msg || '发送失败')
      isSending.value = false
    }
  } catch (error) {
    console.error('发送验证码错误:', error)
    const errorMsg = error.response?.data?.msg || '系统错误，发送失败'
    ElMessage.error(errorMsg)
    isSending.value = false
  }
}

// === 提交注册 ===
const submitRegister = async (formEl) => {
  if (!formEl) return

  await formEl.validate(async (valid, fields) => {
    if (valid) {
      try {
        const { confirmPassword, ...registerData } = registerForm
        // 发送给后端的包含: username, email, password, code
        const response = await axios.post('/api/user/register', registerData)

        if (response.data.success) {
          ElMessageBox.alert('注册成功！', '提示', {
            confirmButtonText: '确定',
            callback: () => {
              router.push('/login')
            }
          })
        } else {
          ElMessageBox.alert(response.data.msg || '注册失败', '错误')
        }
      } catch (error) {
        ElMessageBox.alert('注册失败，请稍后重试', '系统错误')
        console.error('注册错误:', error)
      }
    } else {
      console.log('表单验证失败:', fields)
    }
  })
}

const goToLogin = () => {
  router.push('/login')
}

// 销毁时清理定时器
onUnmounted(() => {
  if (timer) clearInterval(timer)
})
</script>

<style scoped>
.register-container {
  padding: 60px 20px;
  min-height: 100vh;
  background-color: #f5f5f5;
}

.register-title {
  font-size: 2.5rem;
  color: #333;
  text-align: center;
  margin-bottom: 40px;
}

.el-form {
  background: white;
  padding: 40px 30px;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}
</style>