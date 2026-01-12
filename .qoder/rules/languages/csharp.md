---
description: C#/.NET 专属实践规范
globs: ["**/*.cs", "**/*.csproj", "**/*.sln"]
alwaysApply: false
---
最近更新: 2025-10-10

# C#/.NET 专属实践规范

## 1. 命名规范

### 1.1 类和接口
```csharp
// 类名使用 PascalCase
public class UserService { }

// 接口以 I 开头
public interface IUserRepository { }

// 抽象类可以 Abstract 开头或结尾
public abstract class AbstractUserService { }
```

### 1.2 方法和属性
```csharp
// 方法名使用 PascalCase
public async Task<User> GetUserByIdAsync(int userId) { }

// 属性使用 PascalCase
public string UserName { get; set; }

// 私有字段使用 camelCase 或 _camelCase
private readonly ILogger _logger;
private string userName;
```

### 1.3 常量和枚举
```csharp
// 常量使用 PascalCase
public const int MaxRetryCount = 3;

// 枚举使用 PascalCase
public enum UserStatus
{
    Active,
    Inactive,
    Suspended
}
```

## 2. 异步编程

### 2.1 异步方法规范
```csharp
// 异步方法以 Async 结尾
public async Task<string> GetDataAsync()
{
    // 使用 ConfigureAwait(false) 避免死锁
    var result = await httpClient.GetStringAsync(url).ConfigureAwait(false);
    return result;
}

// 避免 async void，除了事件处理器
public async void Button_Click(object sender, EventArgs e) // 仅限事件处理
{
    await ProcessAsync();
}
```

### 2.2 取消令牌
```csharp
public async Task<User> GetUserAsync(int id, CancellationToken cancellationToken = default)
{
    return await repository.GetByIdAsync(id, cancellationToken);
}
```

## 3. 错误处理

### 3.1 异常处理
```csharp
// 使用具体的异常类型
public User GetUser(int id)
{
    if (id <= 0)
        throw new ArgumentException("用户ID必须大于0", nameof(id));
    
    var user = repository.GetById(id);
    if (user == null)
        throw new UserNotFoundException($"未找到ID为{id}的用户");
    
    return user;
}
```

### 3.2 使用 Result 模式
```csharp
public class Result<T>
{
    public bool IsSuccess { get; }
    public T Value { get; }
    public string Error { get; }
    
    private Result(bool isSuccess, T value, string error)
    {
        IsSuccess = isSuccess;
        Value = value;
        Error = error;
    }
    
    public static Result<T> Success(T value) => new(true, value, null);
    public static Result<T> Failure(string error) => new(false, default, error);
}
```

## 4. 依赖注入

### 4.1 服务注册
```csharp
// Program.cs 或 Startup.cs
services.AddScoped<IUserService, UserService>();
services.AddSingleton<IConfiguration>(configuration);
services.AddTransient<IEmailService, EmailService>();
```

### 4.2 构造函数注入
```csharp
public class UserService : IUserService
{
    private readonly IUserRepository _repository;
    private readonly ILogger<UserService> _logger;
    
    public UserService(IUserRepository repository, ILogger<UserService> logger)
    {
        _repository = repository ?? throw new ArgumentNullException(nameof(repository));
        _logger = logger ?? throw new ArgumentNullException(nameof(logger));
    }
}
```

## 5. LINQ 和集合

### 5.1 LINQ 最佳实践
```csharp
// 使用方法链式调用
var activeUsers = users
    .Where(u => u.IsActive)
    .OrderBy(u => u.Name)
    .Select(u => new UserDto { Id = u.Id, Name = u.Name })
    .ToList();

// 避免多次枚举
var userList = users.ToList(); // 一次性转换
var count = userList.Count;
var first = userList.FirstOrDefault();
```

### 5.2 集合初始化
```csharp
// 使用集合初始化器
var numbers = new List<int> { 1, 2, 3, 4, 5 };

// 使用字典初始化器
var statusMap = new Dictionary<int, string>
{
    { 1, "Active" },
    { 2, "Inactive" }
};
```

## 6. 性能优化

### 6.1 字符串处理
```csharp
// 使用 StringBuilder 处理大量字符串拼接
var sb = new StringBuilder();
foreach (var item in items)
{
    sb.AppendLine(item.ToString());
}
var result = sb.ToString();

// 使用 string.Join 连接字符串
var joined = string.Join(", ", items.Select(i => i.Name));
```

### 6.2 内存管理
```csharp
// 使用 using 语句自动释放资源
using var connection = new SqlConnection(connectionString);
using var command = new SqlCommand(sql, connection);

// 使用 IDisposable 模式
public class ResourceManager : IDisposable
{
    private bool disposed = false;
    
    public void Dispose()
    {
        Dispose(true);
        GC.SuppressFinalize(this);
    }
    
    protected virtual void Dispose(bool disposing)
    {
        if (!disposed)
        {
            if (disposing)
            {
                // 释放托管资源
            }
            disposed = true;
        }
    }
}
```

## 7. 日志记录

### 7.1 结构化日志
```csharp
// 使用结构化日志
_logger.LogInformation("用户 {UserId} 执行了 {Action} 操作", userId, action);

// 使用日志作用域
using (_logger.BeginScope("处理订单 {OrderId}", orderId))
{
    _logger.LogInformation("开始处理订单");
    // 处理逻辑
    _logger.LogInformation("订单处理完成");
}
```

## 8. 单元测试

### 8.1 测试命名
```csharp
[Test]
public void GetUser_WhenUserExists_ReturnsUser()
{
    // Arrange
    var userId = 1;
    var expectedUser = new User { Id = userId, Name = "张三" };
    
    // Act
    var result = userService.GetUser(userId);
    
    // Assert
    Assert.AreEqual(expectedUser.Name, result.Name);
}
```

### 8.2 Mock 使用
```csharp
[Test]
public void GetUser_WhenRepositoryThrows_ThrowsException()
{
    // Arrange
    var mockRepository = new Mock<IUserRepository>();
    mockRepository.Setup(r => r.GetById(It.IsAny<int>()))
              .Throws<DatabaseException>();
    
    var service = new UserService(mockRepository.Object);
    
    // Act & Assert
    Assert.Throws<DatabaseException>(() => service.GetUser(1));
}
```

## 9. WPF 项目技术栈建议

### 9.1 推荐技术框架
WPF 项目建议使用以下技术栈：

- **.NET 版本**: .NET 10
- **UI框架**: WPF
- **MVVM框架**: CommunityToolkit.Mvvm
- **UI组件库**: MaterialDesignThemes
- **图表库**: LiveCharts2
- **JSON序列化**: System.Text.Json（默认使用，不使用 Newtonsoft.Json）

### 9.2 项目结构示例
```csharp
// ViewModel 基类（使用 CommunityToolkit.Mvvm）
using CommunityToolkit.Mvvm.ComponentModel;
using CommunityToolkit.Mvvm.Input;

public partial class MainViewModel : ObservableObject
{
    [ObservableProperty]
    private string _title = "WPF Application";
    
    [RelayCommand]
    private void LoadData()
    {
        // 命令处理逻辑
    }
}
```

### 9.3 依赖注入配置
```csharp
// App.xaml.cs
public partial class App : Application
{
    private ServiceProvider? _serviceProvider;
    
    protected override void OnStartup(StartupEventArgs e)
    {
        var serviceCollection = new ServiceCollection();
        ConfigureServices(serviceCollection);
        _serviceProvider = serviceCollection.BuildServiceProvider();
        
        var mainWindow = _serviceProvider.GetRequiredService<MainWindow>();
        mainWindow.Show();
    }
    
    private void ConfigureServices(IServiceCollection services)
    {
        services.AddSingleton<MainWindow>();
        services.AddTransient<MainViewModel>();
        services.AddTransient<IDataService, DataService>();
    }
}
```

### 9.4 Material Design 集成
```xml
<!-- App.xaml -->
<Application.Resources>
    <ResourceDictionary>
        <ResourceDictionary.MergedDictionaries>
            <materialDesign:BundledTheme BaseTheme="Light" PrimaryColor="DeepPurple" SecondaryColor="Lime" />
            <ResourceDictionary Source="pack://application:,,,/MaterialDesignThemes.Wpf;component/Themes/MaterialDesignTheme.Defaults.xaml" />
        </ResourceDictionary.MergedDictionaries>
    </ResourceDictionary>
</Application.Resources>
```

### 9.5 数据绑定最佳实践
```csharp
// ViewModel 中使用 ObservableProperty
public partial class UserViewModel : ObservableObject
{
    [ObservableProperty]
    private string _userName = string.Empty;
    
    [ObservableProperty]
    private bool _isLoading;
    
    // 计算属性
    public string DisplayName => $"用户: {UserName}";
    
    // 部分方法，属性变更时自动调用
    partial void OnUserNameChanged(string value)
    {
        // 属性变更处理逻辑
    }
}
```

### 9.6 JSON 序列化规范
在 WPF 和 .NET 10 项目中，**必须使用 System.Text.Json**，禁止使用 Newtonsoft.Json。

#### 9.6.1 基本使用
```csharp
using System.Text.Json;
using System.Text.Json.Serialization;

// 序列化
var user = new User { Id = 1, Name = "张三" };
string json = JsonSerializer.Serialize(user);

// 反序列化
var deserializedUser = JsonSerializer.Deserialize<User>(json);
```

#### 9.6.2 配置选项
```csharp
// 配置 JsonSerializerOptions
var options = new JsonSerializerOptions
{
    PropertyNamingPolicy = JsonNamingPolicy.CamelCase,  // 驼峰命名
    WriteIndented = true,                                // 格式化输出
    DefaultIgnoreCondition = JsonIgnoreCondition.WhenWritingNull,  // 忽略 null 值
    Encoder = System.Text.Encodings.Web.JavaScriptEncoder.UnsafeRelaxedJsonEscaping  // 宽松编码
};

string json = JsonSerializer.Serialize(user, options);
```

#### 9.6.3 属性特性
```csharp
public class User
{
    [JsonPropertyName("user_id")]  // 自定义 JSON 属性名
    public int Id { get; set; }
    
    [JsonIgnore]  // 忽略序列化
    public string Password { get; set; }
    
    [JsonInclude]  // 包含私有字段
    private string _internalField;
}
```

#### 9.6.4 异步序列化
```csharp
// 异步序列化到流
using var stream = new MemoryStream();
await JsonSerializer.SerializeAsync(stream, user, options);

// 异步从流反序列化
stream.Position = 0;
var user = await JsonSerializer.DeserializeAsync<User>(stream, options);
```

#### 9.6.5 迁移说明
如果项目中有使用 Newtonsoft.Json 的代码，需要迁移到 System.Text.Json：
- 使用 `JsonSerializer.Serialize()` 替代 `JsonConvert.SerializeObject()`
- 使用 `JsonSerializer.Deserialize<T>()` 替代 `JsonConvert.DeserializeObject<T>()`
- 使用 `JsonPropertyName` 替代 `JsonProperty`
- 使用 `JsonIgnore` 替代 `JsonIgnoreAttribute`
- 注意：System.Text.Json 默认区分大小写，行为可能与 Newtonsoft.Json 不同

---
**注意**: 遵循 Microsoft 的 C# 编码规范和 .NET 最佳实践。