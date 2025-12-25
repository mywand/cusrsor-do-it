---
description: Vue 3 专属实践规范
globs: ["**/*.vue", "**/vue.config.js", "**/vite.config.js"]
alwaysApply: false
---
最近更新: 2025-10-10

# Vue 3 专属实践规范

## 1. 组件规范

### 1.1 组件命名
```vue
<!-- 使用 PascalCase 命名组件文件 -->
<!-- UserProfile.vue -->
<template>
  <div class="user-profile">
    <!-- 内容 -->
  </div>
</template>

<script setup lang="ts">
// 组件逻辑
</script>
```

### 1.2 组件结构
```vue
<template>
  <!-- 模板内容 -->
</template>

<script setup lang="ts">
// 1. 导入
import { ref, computed, onMounted } from 'vue'
import type { User } from '@/types'

// 2. Props 定义
interface Props {
  userId: number
  showDetails?: boolean
}
const props = withDefaults(defineProps<Props>(), {
  showDetails: false
})

// 3. Emits 定义
interface Emits {
  update: [user: User]
  delete: [id: number]
}
const emit = defineEmits<Emits>()

// 4. 响应式数据
const user = ref<User | null>(null)
const loading = ref(false)

// 5. 计算属性
const displayName = computed(() => 
  user.value ? `${user.value.firstName} ${user.value.lastName}` : ''
)

// 6. 方法
const loadUser = async () => {
  loading.value = true
  try {
    // 加载用户数据
  } finally {
    loading.value = false
  }
}

// 7. 生命周期
onMounted(() => {
  loadUser()
})
</script>

<style scoped>
/* 样式 */
</style>
```

## 2. Composition API

### 2.1 响应式数据
```typescript
import { ref, reactive, computed } from 'vue'

// 使用 ref 处理基本类型
const count = ref(0)
const message = ref('')

// 使用 reactive 处理对象
const state = reactive({
  user: null as User | null,
  loading: false,
  error: ''
})

// 计算属性
const doubleCount = computed(() => count.value * 2)

// 只读计算属性
const userDisplayName = computed(() => 
  state.user ? `${state.user.name} (${state.user.email})` : '未登录'
)
```

### 2.2 组合式函数 (Composables)
```typescript
// composables/useUser.ts
import { ref, computed } from 'vue'
import type { User } from '@/types'

export function useUser() {
  const user = ref<User | null>(null)
  const loading = ref(false)
  const error = ref('')

  const isLoggedIn = computed(() => user.value !== null)

  const login = async (credentials: LoginCredentials) => {
    loading.value = true
    error.value = ''
    
    try {
      const response = await authApi.login(credentials)
      user.value = response.user
    } catch (err) {
      error.value = err instanceof Error ? err.message : '登录失败'
    } finally {
      loading.value = false
    }
  }

  const logout = () => {
    user.value = null
    // 清理相关状态
  }

  return {
    user: readonly(user),
    loading: readonly(loading),
    error: readonly(error),
    isLoggedIn,
    login,
    logout
  }
}
```

## 3. 状态管理 (Pinia)

### 3.1 Store 定义
```typescript
// stores/user.ts
import { defineStore } from 'pinia'
import type { User } from '@/types'

interface UserState {
  user: User | null
  loading: boolean
  error: string
}

export const useUserStore = defineStore('user', {
  state: (): UserState => ({
    user: null,
    loading: false,
    error: ''
  }),

  getters: {
    isLoggedIn: (state) => state.user !== null,
    displayName: (state) => 
      state.user ? `${state.user.firstName} ${state.user.lastName}` : ''
  },

  actions: {
    async fetchUser(id: number) {
      this.loading = true
      this.error = ''
      
      try {
        const user = await userApi.getById(id)
        this.user = user
      } catch (error) {
        this.error = error instanceof Error ? error.message : '获取用户失败'
      } finally {
        this.loading = false
      }
    },

    clearUser() {
      this.user = null
      this.error = ''
    }
  }
})
```

### 3.2 在组件中使用 Store
```vue
<script setup lang="ts">
import { useUserStore } from '@/stores/user'

const userStore = useUserStore()

// 响应式访问
const { user, loading, isLoggedIn } = storeToRefs(userStore)

// 调用 actions
const handleLogin = () => {
  userStore.fetchUser(123)
}
</script>
```

## 4. 路由管理

### 4.1 路由定义
```typescript
// router/index.ts
import { createRouter, createWebHistory } from 'vue-router'
import type { RouteRecordRaw } from 'vue-router'

const routes: RouteRecordRaw[] = [
  {
    path: '/',
    name: 'Home',
    component: () => import('@/views/Home.vue')
  },
  {
    path: '/user/:id',
    name: 'UserDetail',
    component: () => import('@/views/UserDetail.vue'),
    props: true, // 将路由参数作为 props 传递
    meta: {
      requiresAuth: true
    }
  }
]

export const router = createRouter({
  history: createWebHistory(),
  routes
})

// 路由守卫
router.beforeEach((to, from, next) => {
  const userStore = useUserStore()
  
  if (to.meta.requiresAuth && !userStore.isLoggedIn) {
    next('/login')
  } else {
    next()
  }
})
```

### 4.2 在组件中使用路由
```vue
<script setup lang="ts">
import { useRoute, useRouter } from 'vue-router'

const route = useRoute()
const router = useRouter()

// 获取路由参数
const userId = computed(() => Number(route.params.id))

// 编程式导航
const goToUser = (id: number) => {
  router.push({ name: 'UserDetail', params: { id } })
}
</script>
```

## 5. 表单处理

### 5.1 表单验证
```vue
<template>
  <form @submit.prevent="handleSubmit">
    <div>
      <label>用户名</label>
      <input 
        v-model="form.username" 
        :class="{ 'error': errors.username }"
        @blur="validateUsername"
      />
      <span v-if="errors.username" class="error-message">
        {{ errors.username }}
      </span>
    </div>
    
    <button type="submit" :disabled="!isFormValid">提交</button>
  </form>
</template>

<script setup lang="ts">
import { reactive, computed } from 'vue'

const form = reactive({
  username: '',
  email: '',
  password: ''
})

const errors = reactive({
  username: '',
  email: '',
  password: ''
})

const validateUsername = () => {
  if (!form.username) {
    errors.username = '用户名不能为空'
  } else if (form.username.length < 3) {
    errors.username = '用户名至少3个字符'
  } else {
    errors.username = ''
  }
}

const isFormValid = computed(() => 
  !errors.username && !errors.email && !errors.password &&
  form.username && form.email && form.password
)

const handleSubmit = async () => {
  if (!isFormValid.value) return
  
  try {
    await submitForm(form)
  } catch (error) {
    // 处理错误
  }
}
</script>
```

## 6. 性能优化

### 6.1 懒加载和异步组件
```typescript
// 路由懒加载
const UserDetail = () => import('@/views/UserDetail.vue')

// 异步组件
import { defineAsyncComponent } from 'vue'

const AsyncComponent = defineAsyncComponent({
  loader: () => import('./HeavyComponent.vue'),
  loadingComponent: LoadingSpinner,
  errorComponent: ErrorComponent,
  delay: 200,
  timeout: 3000
})
```

### 6.2 v-memo 和计算属性优化
```vue
<template>
  <!-- 使用 v-memo 缓存昂贵的渲染 -->
  <div v-memo="[user.id, user.name]">
    <UserCard :user="user" />
  </div>
  
  <!-- 使用 v-once 一次性渲染 -->
  <div v-once>
    {{ expensiveCalculation() }}
  </div>
</template>

<script setup lang="ts">
// 使用 shallowRef 优化大对象
import { shallowRef } from 'vue'

const largeData = shallowRef(/* 大数据对象 */)
</script>
```

## 7. TypeScript 集成

### 7.1 类型定义
```typescript
// types/user.ts
export interface User {
  id: number
  name: string
  email: string
  avatar?: string
  createdAt: Date
}

export interface CreateUserRequest {
  name: string
  email: string
  password: string
}

export type UserStatus = 'active' | 'inactive' | 'pending'
```

### 7.2 组件类型安全
```vue
<script setup lang="ts">
import type { User } from '@/types'

// Props 类型定义
interface Props {
  user: User
  editable?: boolean
}

// 使用泛型定义响应式数据
const users = ref<User[]>([])
const selectedUser = ref<User | null>(null)

// 事件类型定义
interface Emits {
  'user-updated': [user: User]
  'user-deleted': [id: number]
}
const emit = defineEmits<Emits>()
</script>
```

## 8. 测试

### 8.1 组件测试
```typescript
// UserProfile.spec.ts
import { mount } from '@vue/test-utils'
import UserProfile from '@/components/UserProfile.vue'
import type { User } from '@/types'

describe('UserProfile', () => {
  const mockUser: User = {
    id: 1,
    name: '张三',
    email: 'zhangsan@example.com'
  }

  it('应该正确显示用户信息', () => {
    const wrapper = mount(UserProfile, {
      props: { user: mockUser }
    })

    expect(wrapper.text()).toContain('张三')
    expect(wrapper.text()).toContain('zhangsan@example.com')
  })

  it('应该在点击编辑时触发事件', async () => {
    const wrapper = mount(UserProfile, {
      props: { user: mockUser, editable: true }
    })

    await wrapper.find('.edit-button').trigger('click')
    
    expect(wrapper.emitted('edit')).toBeTruthy()
  })
})
```

---
**注意**: 遵循 Vue 3 官方风格指南和 TypeScript 最佳实践。