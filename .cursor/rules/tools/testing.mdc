---
description: 测试策略与最佳实践
globs: ["**/*test*", "**/*spec*"]
alwaysApply: false
---
最近更新: 2025-10-10

# 测试策略与最佳实践

## 1. 测试金字塔

### 1.1 测试层级
```
    /\
   /  \
  / UI \     <- 少量 E2E 测试
 /______\
/        \
| 集成测试 |   <- 适量集成测试
|________|
|        |
| 单元测试 |   <- 大量单元测试
|________|
```

### 1.2 测试比例建议
- **单元测试**: 70% - 快速、稳定、易维护
- **集成测试**: 20% - 测试组件间交互
- **端到端测试**: 10% - 测试完整用户流程

## 2. 单元测试

### 2.1 测试命名规范
```javascript
// 格式: 方法名_测试场景_期望结果
describe('UserService', () => {
  describe('getUserById', () => {
    it('should return user when valid id provided', () => {
      // 测试逻辑
    })
    
    it('should throw error when invalid id provided', () => {
      // 测试逻辑
    })
    
    it('should return null when user not found', () => {
      // 测试逻辑
    })
  })
})
```

### 2.2 AAA 模式 (Arrange-Act-Assert)
```python
def test_calculate_discount_with_valid_inputs():
    # Arrange - 准备测试数据
    price = 100
    discount_rate = 0.1
    expected_discount = 10
    
    # Act - 执行被测试的方法
    actual_discount = calculate_discount(price, discount_rate)
    
    # Assert - 验证结果
    assert actual_discount == expected_discount
```

### 2.3 Mock 和 Stub 使用
```java
@Test
public void shouldCreateUserSuccessfully() {
    // Arrange
    CreateUserRequest request = new CreateUserRequest("张三", "zhang@example.com");
    User expectedUser = new User(1, "张三", "zhang@example.com");
    
    // Mock 外部依赖
    when(userRepository.save(any(User.class))).thenReturn(expectedUser);
    when(emailService.sendWelcomeEmail(anyString())).thenReturn(true);
    
    // Act
    User actualUser = userService.createUser(request);
    
    // Assert
    assertEquals(expectedUser.getName(), actualUser.getName());
    assertEquals(expectedUser.getEmail(), actualUser.getEmail());
    
    // 验证交互
    verify(userRepository).save(any(User.class));
    verify(emailService).sendWelcomeEmail("zhang@example.com");
}
```

### 2.4 边界测试
```typescript
describe('validateAge', () => {
  it('should accept minimum valid age', () => {
    expect(validateAge(0)).toBe(true)
  })
  
  it('should accept maximum valid age', () => {
    expect(validateAge(150)).toBe(true)
  })
  
  it('should reject negative age', () => {
    expect(() => validateAge(-1)).toThrow('年龄不能为负数')
  })
  
  it('should reject age over limit', () => {
    expect(() => validateAge(151)).toThrow('年龄不能超过150岁')
  })
  
  it('should handle null input', () => {
    expect(() => validateAge(null)).toThrow('年龄不能为空')
  })
})
```

## 3. 集成测试

### 3.1 数据库集成测试
```csharp
[TestClass]
public class UserRepositoryIntegrationTests
{
    private TestDbContext _context;
    private UserRepository _repository;
    
    [TestInitialize]
    public void Setup()
    {
        var options = new DbContextOptionsBuilder<TestDbContext>()
            .UseInMemoryDatabase(databaseName: Guid.NewGuid().ToString())
            .Options;
            
        _context = new TestDbContext(options);
        _repository = new UserRepository(_context);
    }
    
    [TestMethod]
    public async Task ShouldSaveAndRetrieveUser()
    {
        // Arrange
        var user = new User { Name = "张三", Email = "zhang@example.com" };
        
        // Act
        var savedUser = await _repository.SaveAsync(user);
        var retrievedUser = await _repository.GetByIdAsync(savedUser.Id);
        
        // Assert
        Assert.IsNotNull(retrievedUser);
        Assert.AreEqual(user.Name, retrievedUser.Name);
        Assert.AreEqual(user.Email, retrievedUser.Email);
    }
    
    [TestCleanup]
    public void Cleanup()
    {
        _context.Dispose();
    }
}
```

### 3.2 API 集成测试
```python
import pytest
import requests
from unittest import TestCase

class TestUserAPI(TestCase):
    def setUp(self):
        self.base_url = "http://localhost:8000/api"
        self.headers = {"Content-Type": "application/json"}
    
    def test_create_user_success(self):
        # Arrange
        user_data = {
            "name": "张三",
            "email": "zhang@example.com",
            "password": "securePassword123"
        }
        
        # Act
        response = requests.post(
            f"{self.base_url}/users",
            json=user_data,
            headers=self.headers
        )
        
        # Assert
        self.assertEqual(response.status_code, 201)
        
        response_data = response.json()
        self.assertEqual(response_data["name"], user_data["name"])
        self.assertEqual(response_data["email"], user_data["email"])
        self.assertNotIn("password", response_data)  # 确保密码不返回
    
    def test_create_user_with_invalid_email(self):
        # Arrange
        user_data = {
            "name": "张三",
            "email": "invalid-email",
            "password": "securePassword123"
        }
        
        # Act
        response = requests.post(
            f"{self.base_url}/users",
            json=user_data,
            headers=self.headers
        )
        
        # Assert
        self.assertEqual(response.status_code, 400)
        self.assertIn("邮箱格式不正确", response.json()["message"])
```

## 4. 端到端测试

### 4.1 Web 应用 E2E 测试
```javascript
// 使用 Cypress
describe('用户注册流程', () => {
  beforeEach(() => {
    cy.visit('/register')
  })
  
  it('应该能够成功注册新用户', () => {
    // 填写注册表单
    cy.get('[data-testid=name-input]').type('张三')
    cy.get('[data-testid=email-input]').type('zhang@example.com')
    cy.get('[data-testid=password-input]').type('securePassword123')
    cy.get('[data-testid=confirm-password-input]').type('securePassword123')
    
    // 提交表单
    cy.get('[data-testid=submit-button]').click()
    
    // 验证结果
    cy.url().should('include', '/welcome')
    cy.get('[data-testid=welcome-message]').should('contain', '欢迎，张三')
    
    // 验证邮件发送（如果有邮件服务）
    cy.task('checkEmail', 'zhang@example.com').should('contain', '欢迎注册')
  })
  
  it('应该显示密码不匹配错误', () => {
    cy.get('[data-testid=name-input]').type('张三')
    cy.get('[data-testid=email-input]').type('zhang@example.com')
    cy.get('[data-testid=password-input]').type('password123')
    cy.get('[data-testid=confirm-password-input]').type('differentPassword')
    
    cy.get('[data-testid=submit-button]').click()
    
    cy.get('[data-testid=error-message]').should('contain', '密码不匹配')
  })
})
```

### 4.2 移动应用 E2E 测试
```javascript
// 使用 Detox (React Native)
describe('用户登录', () => {
  beforeEach(async () => {
    await device.reloadReactNative()
  })
  
  it('应该能够成功登录', async () => {
    // 输入用户名和密码
    await element(by.id('usernameInput')).typeText('zhang@example.com')
    await element(by.id('passwordInput')).typeText('password123')
    
    // 点击登录按钮
    await element(by.id('loginButton')).tap()
    
    // 验证登录成功
    await expect(element(by.id('homeScreen'))).toBeVisible()
    await expect(element(by.text('欢迎回来'))).toBeVisible()
  })
})
```

## 5. 测试数据管理

### 5.1 测试数据构建器模式
```java
public class UserTestDataBuilder {
    private String name = "默认用户";
    private String email = "default@example.com";
    private int age = 25;
    private boolean isActive = true;
    
    public UserTestDataBuilder withName(String name) {
        this.name = name;
        return this;
    }
    
    public UserTestDataBuilder withEmail(String email) {
        this.email = email;
        return this;
    }
    
    public UserTestDataBuilder withAge(int age) {
        this.age = age;
        return this;
    }
    
    public UserTestDataBuilder inactive() {
        this.isActive = false;
        return this;
    }
    
    public User build() {
        return new User(name, email, age, isActive);
    }
}

// 使用示例
@Test
public void shouldCreateActiveUser() {
    User user = new UserTestDataBuilder()
        .withName("张三")
        .withEmail("zhang@example.com")
        .withAge(30)
        .build();
        
    User savedUser = userService.createUser(user);
    
    assertTrue(savedUser.isActive());
}
```

### 5.2 测试夹具 (Fixtures)
```python
# conftest.py
import pytest
from models import User, Order

@pytest.fixture
def sample_user():
    return User(
        name="张三",
        email="zhang@example.com",
        age=30
    )

@pytest.fixture
def sample_order(sample_user):
    return Order(
        user=sample_user,
        amount=100.0,
        status="pending"
    )

# test_order_service.py
def test_process_order(sample_order):
    # 使用夹具提供的测试数据
    result = order_service.process(sample_order)
    
    assert result.status == "processed"
    assert result.amount == sample_order.amount
```

## 6. 测试覆盖率

### 6.1 覆盖率目标
- **行覆盖率**: 至少 80%
- **分支覆盖率**: 至少 70%
- **函数覆盖率**: 至少 90%

### 6.2 覆盖率工具配置
```javascript
// jest.config.js
module.exports = {
  collectCoverage: true,
  coverageDirectory: 'coverage',
  coverageReporters: ['text', 'lcov', 'html'],
  coverageThreshold: {
    global: {
      branches: 70,
      functions: 90,
      lines: 80,
      statements: 80
    }
  },
  collectCoverageFrom: [
    'src/**/*.{js,ts}',
    '!src/**/*.d.ts',
    '!src/**/*.test.{js,ts}',
    '!src/index.ts'
  ]
}
```

## 7. 性能测试

### 7.1 负载测试
```javascript
// 使用 k6
import http from 'k6/http'
import { check, sleep } from 'k6'

export let options = {
  stages: [
    { duration: '2m', target: 100 }, // 2分钟内增加到100个用户
    { duration: '5m', target: 100 }, // 保持100个用户5分钟
    { duration: '2m', target: 200 }, // 2分钟内增加到200个用户
    { duration: '5m', target: 200 }, // 保持200个用户5分钟
    { duration: '2m', target: 0 },   // 2分钟内减少到0个用户
  ],
}

export default function () {
  let response = http.get('http://localhost:8000/api/users')
  
  check(response, {
    '状态码是200': (r) => r.status === 200,
    '响应时间小于500ms': (r) => r.timings.duration < 500,
  })
  
  sleep(1)
}
```

### 7.2 基准测试
```go
// Go 基准测试示例
func BenchmarkCalculateDiscount(b *testing.B) {
    for i := 0; i < b.N; i++ {
        CalculateDiscount(100.0, 0.1)
    }
}

func BenchmarkCalculateDiscountParallel(b *testing.B) {
    b.RunParallel(func(pb *testing.PB) {
        for pb.Next() {
            CalculateDiscount(100.0, 0.1)
        }
    })
}
```

## 8. 测试最佳实践

### 8.1 测试独立性
```python
# ❌ 测试间有依赖
class TestUserService:
    def test_create_user(self):
        user = user_service.create_user("张三", "zhang@example.com")
        self.created_user_id = user.id  # 不好：存储状态
    
    def test_get_user(self):
        user = user_service.get_user(self.created_user_id)  # 不好：依赖前一个测试
        assert user.name == "张三"

# ✅ 独立的测试
class TestUserService:
    def test_create_user(self):
        user = user_service.create_user("张三", "zhang@example.com")
        assert user.name == "张三"
        assert user.email == "zhang@example.com"
    
    def test_get_user(self):
        # 每个测试都准备自己的数据
        created_user = user_service.create_user("李四", "li@example.com")
        retrieved_user = user_service.get_user(created_user.id)
        assert retrieved_user.name == "李四"
```

### 8.2 测试可读性
```typescript
// ✅ 清晰的测试描述
describe('订单计算服务', () => {
  describe('当计算订单总价时', () => {
    it('应该正确计算包含税费的总价', () => {
      // Given: 有一个包含多个商品的订单
      const order = new OrderBuilder()
        .withItem('商品A', 100, 2)  // 单价100，数量2
        .withItem('商品B', 50, 1)   // 单价50，数量1
        .withTaxRate(0.1)           // 税率10%
        .build()
      
      // When: 计算总价
      const total = orderCalculator.calculateTotal(order)
      
      // Then: 总价应该是 (100*2 + 50*1) * 1.1 = 275
      expect(total).toBe(275)
    })
  })
})
```

### 8.3 测试维护
```java
// ✅ 使用常量避免魔法数字
public class UserServiceTest {
    private static final String VALID_EMAIL = "zhang@example.com";
    private static final String INVALID_EMAIL = "invalid-email";
    private static final int VALID_AGE = 25;
    private static final int INVALID_AGE = -1;
    
    @Test
    public void shouldCreateUserWithValidData() {
        CreateUserRequest request = new CreateUserRequest("张三", VALID_EMAIL, VALID_AGE);
        
        User user = userService.createUser(request);
        
        assertEquals("张三", user.getName());
        assertEquals(VALID_EMAIL, user.getEmail());
        assertEquals(VALID_AGE, user.getAge());
    }
}
```

---
**重要**: 测试是代码质量的重要保障，应该与业务代码同等重视。好的测试不仅能发现问题，还能作为代码的活文档。