---
description: Python 专属实践规范
globs: ["**/*.py", "**/requirements.txt", "**/pyproject.toml", "**/setup.py"]
alwaysApply: false
---
最近更新: 2025-10-10

# Python 专属实践规范

## 1. 项目结构规范

### 1.1 标准项目结构
```
my_project/
├── README.md                    # 项目说明
├── pyproject.toml              # 项目配置（推荐）
├── requirements.txt            # 依赖列表（可选）
├── setup.py                    # 安装脚本（传统方式）
├── .gitignore                  # Git忽略文件
├── .env.example                # 环境变量示例
├── Dockerfile                  # Docker配置
├── docker-compose.yml          # Docker编排
├── Makefile                    # 构建脚本
├── src/                        # 源代码目录（推荐）
│   └── my_project/
│       ├── __init__.py
│       ├── main.py             # 程序入口
│       ├── config/             # 配置模块
│       │   ├── __init__.py
│       │   ├── settings.py     # 配置设置
│       │   └── database.py     # 数据库配置
│       ├── models/             # 数据模型
│       │   ├── __init__.py
│       │   ├── user.py
│       │   └── base.py
│       ├── services/           # 业务逻辑层
│       │   ├── __init__.py
│       │   ├── user_service.py
│       │   └── auth_service.py
│       ├── repositories/       # 数据访问层
│       │   ├── __init__.py
│       │   ├── user_repository.py
│       │   └── base_repository.py
│       ├── api/                # API层
│       │   ├── __init__.py
│       │   ├── routes/
│       │   │   ├── __init__.py
│       │   │   ├── users.py
│       │   │   └── auth.py
│       │   ├── middleware/
│       │   └── schemas/        # API模式定义
│       ├── utils/              # 工具函数
│       │   ├── __init__.py
│       │   ├── helpers.py
│       │   └── validators.py
│       ├── exceptions/         # 自定义异常
│       │   ├── __init__.py
│       │   └── custom_exceptions.py
│       └── constants/          # 常量定义
│           ├── __init__.py
│           └── app_constants.py
├── tests/                      # 测试目录
│   ├── __init__.py
│   ├── conftest.py            # pytest配置
│   ├── unit/                  # 单元测试
│   │   ├── test_models.py
│   │   ├── test_services.py
│   │   └── test_utils.py
│   ├── integration/           # 集成测试
│   │   ├── test_api.py
│   │   └── test_database.py
│   └── fixtures/              # 测试数据
│       └── sample_data.json
├── docs/                      # 文档目录
│   ├── api.md                 # API文档
│   ├── deployment.md          # 部署文档
│   └── development.md         # 开发文档
├── scripts/                   # 脚本目录
│   ├── migrate.py             # 数据库迁移
│   ├── seed_data.py           # 数据初始化
│   └── deploy.sh              # 部署脚本
├── migrations/                # 数据库迁移文件
├── static/                    # 静态文件（Web项目）
├── templates/                 # 模板文件（Web项目）
└── logs/                      # 日志目录
```

### 1.2 不同类型项目结构

#### Web应用项目（Flask/Django/FastAPI）
```
web_app/
├── app/
│   ├── __init__.py
│   ├── main.py                # 应用入口
│   ├── models/                # 数据模型
│   ├── views/                 # 视图层（Flask）
│   ├── api/                   # API路由
│   ├── services/              # 业务逻辑
│   ├── templates/             # HTML模板
│   ├── static/                # 静态资源
│   └── utils/
├── migrations/                # 数据库迁移
├── tests/
├── requirements.txt
└── config.py
```

#### 数据科学项目
```
data_project/
├── data/
│   ├── raw/                   # 原始数据
│   ├── processed/             # 处理后数据
│   └── external/              # 外部数据
├── notebooks/                 # Jupyter笔记本
│   ├── 01_data_exploration.ipynb
│   ├── 02_feature_engineering.ipynb
│   └── 03_modeling.ipynb
├── src/
│   ├── data/                  # 数据处理
│   ├── features/              # 特征工程
│   ├── models/                # 模型定义
│   └── visualization/         # 可视化
├── models/                    # 训练好的模型
├── reports/                   # 分析报告
└── requirements.txt
```

#### 命令行工具项目
```
cli_tool/
├── src/
│   └── cli_tool/
│       ├── __init__.py
│       ├── cli.py             # 命令行接口
│       ├── commands/          # 子命令
│       ├── core/              # 核心逻辑
│       └── utils/
├── tests/
├── setup.py
└── requirements.txt
```

### 1.3 包结构最佳实践

#### 模块组织原则
```python
# 按功能分组，而不是按类型
# ❌ 不好的组织方式
models/
├── user_model.py
├── order_model.py
└── product_model.py
services/
├── user_service.py
├── order_service.py
└── product_service.py

# ✅ 好的组织方式（大型项目）
user/
├── __init__.py
├── models.py
├── services.py
├── views.py
└── tests.py
order/
├── __init__.py
├── models.py
├── services.py
├── views.py
└── tests.py
```

#### __init__.py 文件使用
```python
# src/my_project/__init__.py
"""
My Project - 项目简短描述

这是一个示例Python项目。
"""

__version__ = "1.0.0"
__author__ = "Your Name"
__email__ = "your.email@example.com"

# 导出主要接口
from .main import main
from .config import settings

__all__ = ["main", "settings"]
```

### 1.4 配置管理结构
```python
# config/settings.py
import os
from pathlib import Path
from typing import Optional

class Settings:
    """应用配置类"""
    
    # 基础配置
    APP_NAME: str = "My Project"
    VERSION: str = "1.0.0"
    DEBUG: bool = os.getenv("DEBUG", "False").lower() == "true"
    
    # 数据库配置
    DATABASE_URL: str = os.getenv("DATABASE_URL", "sqlite:///./app.db")
    
    # Redis配置
    REDIS_URL: str = os.getenv("REDIS_URL", "redis://localhost:6379")
    
    # API配置
    API_PREFIX: str = "/api/v1"
    SECRET_KEY: str = os.getenv("SECRET_KEY", "your-secret-key")
    
    # 日志配置
    LOG_LEVEL: str = os.getenv("LOG_LEVEL", "INFO")
    LOG_FILE: Optional[str] = os.getenv("LOG_FILE")
    
    # 项目根目录
    BASE_DIR: Path = Path(__file__).parent.parent.parent
    
    class Config:
        env_file = ".env"
        env_file_encoding = "utf-8"

# 全局配置实例
settings = Settings()
```

## 2. 代码风格规范

### 2.1 PEP 8 基础规范
```python
# 导入顺序：标准库 -> 第三方库 -> 本地应用
import os
import sys
from datetime import datetime

import requests
import pandas as pd

from .models import User
from ..utils import logger
```

### 2.2 命名规范
```python
# 变量和函数：snake_case
user_name = "张三"
user_age = 25

def get_user_by_id(user_id: int) -> User:
    """根据ID获取用户"""
    pass

# 常量：UPPER_SNAKE_CASE
MAX_RETRY_COUNT = 3
DEFAULT_TIMEOUT = 30

# 类名：PascalCase
class UserService:
    """用户服务类"""
    pass

# 私有属性/方法：前缀下划线
class User:
    def __init__(self, name: str):
        self.name = name
        self._id = None  # 受保护属性
        self.__password = None  # 私有属性
    
    def _validate_data(self):  # 受保护方法
        """验证数据"""
        pass
```

### 2.3 代码格式化
```python
# 使用 Black 格式化工具
# 安装: pip install black
# 使用: black your_file.py

# 长参数列表换行
def create_user(
    name: str,
    email: str,
    age: int,
    phone: str = None,
    address: str = None,
) -> User:
    """创建用户"""
    pass

# 长字典/列表换行
user_data = {
    "name": "张三",
    "email": "zhang@example.com",
    "age": 25,
    "phone": "13800138000",
}

# 链式调用换行
result = (
    df.filter(df.age > 18)
    .select("name", "email")
    .orderBy("name")
    .collect()
)
```

## 3. 类型注解

### 3.1 基础类型注解
```python
from typing import List, Dict, Optional, Union, Tuple, Any

# 基础类型
def calculate_age(birth_year: int) -> int:
    return 2025 - birth_year

# 集合类型
def get_user_names(users: List[User]) -> List[str]:
    return [user.name for user in users]

# 字典类型
def process_config(config: Dict[str, Any]) -> bool:
    return config.get("enabled", False)

# 可选类型
def find_user(user_id: int) -> Optional[User]:
    # 可能返回 None
    return user_repository.get_by_id(user_id)

# 联合类型
def format_id(user_id: Union[int, str]) -> str:
    return str(user_id)
```

### 3.2 高级类型注解
```python
from typing import Protocol, TypeVar, Generic, Callable

# 协议（接口）
class Drawable(Protocol):
    def draw(self) -> None: ...

# 泛型
T = TypeVar('T')

class Repository(Generic[T]):
    def save(self, entity: T) -> T:
        pass
    
    def find_by_id(self, id: int) -> Optional[T]:
        pass

# 回调函数类型
def process_data(
    data: List[str], 
    callback: Callable[[str], bool]
) -> List[str]:
    return [item for item in data if callback(item)]
```

### 3.3 数据类
```python
from dataclasses import dataclass, field
from typing import List
from datetime import datetime

@dataclass
class User:
    """用户数据类"""
    name: str
    email: str
    age: int = 0
    tags: List[str] = field(default_factory=list)
    created_at: datetime = field(default_factory=datetime.now)
    
    def __post_init__(self):
        """初始化后处理"""
        if self.age < 0:
            raise ValueError("年龄不能为负数")

# 使用示例
user = User(name="张三", email="zhang@example.com", age=25)
print(user.name)  # 张三
```

## 4. 异常处理

### 4.1 自定义异常
```python
class BusinessException(Exception):
    """业务异常基类"""
    def __init__(self, message: str, code: str = None):
        super().__init__(message)
        self.message = message
        self.code = code

class UserNotFoundException(BusinessException):
    """用户未找到异常"""
    def __init__(self, user_id: int):
        super().__init__(f"用户ID {user_id} 不存在", "USER_NOT_FOUND")
        self.user_id = user_id

class ValidationException(BusinessException):
    """数据验证异常"""
    def __init__(self, field: str, message: str):
        super().__init__(f"{field}: {message}", "VALIDATION_ERROR")
        self.field = field
```

### 4.2 异常处理最佳实践
```python
import logging
from contextlib import contextmanager

logger = logging.getLogger(__name__)

def get_user(user_id: int) -> User:
    """获取用户，包含完整的异常处理"""
    if user_id <= 0:
        raise ValidationException("user_id", "用户ID必须大于0")
    
    try:
        user = user_repository.get_by_id(user_id)
        if user is None:
            raise UserNotFoundException(user_id)
        return user
    except DatabaseException as e:
        logger.error(f"数据库查询失败: {e}", exc_info=True)
        raise BusinessException("用户查询失败，请稍后重试") from e
    except Exception as e:
        logger.error(f"未知错误: {e}", exc_info=True)
        raise

# 上下文管理器
@contextmanager
def database_transaction():
    """数据库事务上下文管理器"""
    transaction = db.begin_transaction()
    try:
        yield transaction
        transaction.commit()
    except Exception:
        transaction.rollback()
        raise
    finally:
        transaction.close()

# 使用示例
def create_user(user_data: dict) -> User:
    with database_transaction() as tx:
        user = User(**user_data)
        return user_repository.save(user, tx)
```

## 5. 函数式编程

### 5.1 列表推导式和生成器
```python
# 列表推导式
active_users = [user for user in users if user.is_active]
user_emails = [user.email for user in users if user.email]

# 字典推导式
user_dict = {user.id: user.name for user in users}

# 集合推导式
unique_domains = {user.email.split('@')[1] for user in users if user.email}

# 生成器表达式（内存友好）
def process_large_dataset(file_path: str):
    with open(file_path, 'r') as f:
        # 生成器，逐行处理，不会一次性加载所有数据
        for line in f:
            if line.strip():
                yield process_line(line)

# 生成器函数
def fibonacci(n: int):
    """斐波那契数列生成器"""
    a, b = 0, 1
    for _ in range(n):
        yield a
        a, b = b, a + b
```

### 5.2 高阶函数
```python
from functools import reduce, partial
from operator import add

# map, filter, reduce
numbers = [1, 2, 3, 4, 5]
squared = list(map(lambda x: x**2, numbers))  # [1, 4, 9, 16, 25]
evens = list(filter(lambda x: x % 2 == 0, numbers))  # [2, 4]
sum_all = reduce(add, numbers)  # 15

# partial 函数
def multiply(x: int, y: int) -> int:
    return x * y

double = partial(multiply, 2)  # 固定第一个参数为2
result = double(5)  # 10

# 装饰器
from functools import wraps
import time

def timer(func):
    """计时装饰器"""
    @wraps(func)
    def wrapper(*args, **kwargs):
        start = time.time()
        result = func(*args, **kwargs)
        end = time.time()
        print(f"{func.__name__} 执行时间: {end - start:.2f}秒")
        return result
    return wrapper

@timer
def slow_function():
    time.sleep(1)
    return "完成"
```

## 6. 面向对象编程

### 6.1 类设计原则
```python
from abc import ABC, abstractmethod
from typing import Protocol

# 抽象基类
class Animal(ABC):
    def __init__(self, name: str):
        self.name = name
    
    @abstractmethod
    def make_sound(self) -> str:
        """动物叫声"""
        pass
    
    def introduce(self) -> str:
        return f"我是{self.name}，{self.make_sound()}"

# 具体实现
class Dog(Animal):
    def make_sound(self) -> str:
        return "汪汪"

class Cat(Animal):
    def make_sound(self) -> str:
        return "喵喵"

# 协议（鸭子类型）
class Flyable(Protocol):
    def fly(self) -> None: ...

class Bird:
    def fly(self) -> None:
        print("鸟儿在飞")

class Airplane:
    def fly(self) -> None:
        print("飞机在飞")

def make_it_fly(obj: Flyable) -> None:
    obj.fly()  # 只要有fly方法就可以
```

### 6.2 属性和方法
```python
class User:
    def __init__(self, name: str, birth_year: int):
        self._name = name
        self._birth_year = birth_year
        self._email = None
    
    @property
    def name(self) -> str:
        """用户名属性"""
        return self._name
    
    @name.setter
    def name(self, value: str) -> None:
        if not value or not value.strip():
            raise ValueError("用户名不能为空")
        self._name = value.strip()
    
    @property
    def age(self) -> int:
        """计算年龄（只读属性）"""
        from datetime import datetime
        return datetime.now().year - self._birth_year
    
    @property
    def email(self) -> Optional[str]:
        return self._email
    
    @email.setter
    def email(self, value: str) -> None:
        if value and '@' not in value:
            raise ValueError("邮箱格式不正确")
        self._email = value
    
    @classmethod
    def from_dict(cls, data: dict) -> 'User':
        """从字典创建用户"""
        return cls(data['name'], data['birth_year'])
    
    @staticmethod
    def is_valid_email(email: str) -> bool:
        """验证邮箱格式"""
        return '@' in email and '.' in email.split('@')[1]
    
    def __str__(self) -> str:
        return f"User(name={self.name}, age={self.age})"
    
    def __repr__(self) -> str:
        return f"User(name='{self.name}', birth_year={self._birth_year})"
```

## 7. 虚拟环境和依赖管理

### 7.1 虚拟环境管理
```bash
# 使用 venv（Python 3.3+内置）
python -m venv myproject_env

# 激活虚拟环境
# Windows
myproject_env\Scripts\activate
# macOS/Linux
source myproject_env/bin/activate

# 停用虚拟环境
deactivate

# 使用 conda
conda create -n myproject python=3.11
conda activate myproject
conda deactivate

# 使用 poetry（推荐）
poetry init
poetry install
poetry shell
poetry add requests
poetry add pytest --group dev
```

### 7.2 依赖管理最佳实践
```toml
# pyproject.toml（推荐现代方式）
[build-system]
requires = ["setuptools>=45", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "my-project"
version = "1.0.0"
description = "项目描述"
readme = "README.md"
authors = [{name = "作者", email = "author@example.com"}]
license = {text = "MIT"}
classifiers = [
    "Development Status :: 4 - Beta",
    "Intended Audience :: Developers",
    "License :: OSI Approved :: MIT License",
    "Programming Language :: Python :: 3",
    "Programming Language :: Python :: 3.9",
    "Programming Language :: Python :: 3.10",
    "Programming Language :: Python :: 3.11",
]
requires-python = ">=3.9"
dependencies = [
    "requests>=2.28.0",
    "pydantic>=1.10.0",
    "fastapi>=0.95.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=7.0.0",
    "black>=23.0.0",
    "isort>=5.12.0",
    "flake8>=6.0.0",
    "mypy>=1.0.0",
    "pre-commit>=3.0.0",
]
test = [
    "pytest>=7.0.0",
    "pytest-cov>=4.0.0",
    "pytest-asyncio>=0.21.0",
]
docs = [
    "sphinx>=6.0.0",
    "sphinx-rtd-theme>=1.2.0",
]

[project.scripts]
my-cli = "my_project.cli:main"

[tool.setuptools.packages.find]
where = ["src"]

[tool.setuptools.package-dir]
"" = "src"
```

### 7.3 版本固定策略
```python
# requirements.txt（生产环境精确版本）
requests==2.28.2
pydantic==1.10.7
fastapi==0.95.1

# requirements-dev.txt（开发依赖）
-r requirements.txt
pytest==7.2.2
black==23.1.0
isort==5.12.0
flake8==6.0.0
mypy==1.1.1

# 生成精确版本文件
pip freeze > requirements-lock.txt
```

## 8. 文件和I/O操作

### 8.1 文件处理
```python
from pathlib import Path
import json
import csv
from typing import Iterator

# 使用 pathlib（推荐）
def read_config(config_path: str) -> dict:
    """读取配置文件"""
    path = Path(config_path)
    if not path.exists():
        raise FileNotFoundError(f"配置文件不存在: {config_path}")
    
    with path.open('r', encoding='utf-8') as f:
        return json.load(f)

def write_data_to_csv(data: List[dict], file_path: str) -> None:
    """写入CSV文件"""
    path = Path(file_path)
    path.parent.mkdir(parents=True, exist_ok=True)  # 创建目录
    
    with path.open('w', newline='', encoding='utf-8') as f:
        if data:
            writer = csv.DictWriter(f, fieldnames=data[0].keys())
            writer.writeheader()
            writer.writerows(data)

# 大文件处理
def process_large_file(file_path: str) -> Iterator[str]:
    """逐行处理大文件"""
    with open(file_path, 'r', encoding='utf-8') as f:
        for line_num, line in enumerate(f, 1):
            try:
                yield process_line(line.strip())
            except Exception as e:
                print(f"处理第{line_num}行时出错: {e}")
                continue
```

### 8.2 日志配置
```python
import logging
import logging.config
from pathlib import Path

# 日志配置
LOGGING_CONFIG = {
    'version': 1,
    'disable_existing_loggers': False,
    'formatters': {
        'standard': {
            'format': '%(asctime)s [%(levelname)s] %(name)s: %(message)s'
        },
        'detailed': {
            'format': '%(asctime)s [%(levelname)s] %(name)s:%(lineno)d: %(message)s'
        },
    },
    'handlers': {
        'console': {
            'level': 'INFO',
            'class': 'logging.StreamHandler',
            'formatter': 'standard',
        },
        'file': {
            'level': 'DEBUG',
            'class': 'logging.FileHandler',
            'filename': 'app.log',
            'formatter': 'detailed',
            'encoding': 'utf-8',
        },
    },
    'loggers': {
        '': {  # root logger
            'handlers': ['console', 'file'],
            'level': 'DEBUG',
            'propagate': False
        }
    }
}

def setup_logging():
    """设置日志配置"""
    logging.config.dictConfig(LOGGING_CONFIG)

# 使用示例
logger = logging.getLogger(__name__)

def process_user(user_id: int) -> None:
    logger.info(f"开始处理用户: {user_id}")
    try:
        # 处理逻辑
        logger.debug(f"用户 {user_id} 处理完成")
    except Exception as e:
        logger.error(f"处理用户 {user_id} 失败: {e}", exc_info=True)
```

## 9. 测试

### 9.1 单元测试
```python
import unittest
from unittest.mock import Mock, patch, MagicMock
import pytest

class TestUserService(unittest.TestCase):
    def setUp(self):
        """测试前准备"""
        self.user_service = UserService()
        self.mock_repository = Mock()
    
    def test_create_user_success(self):
        """测试创建用户成功"""
        # Arrange
        user_data = {"name": "张三", "email": "zhang@example.com"}
        expected_user = User(id=1, **user_data)
        self.mock_repository.save.return_value = expected_user
        
        # Act
        result = self.user_service.create_user(user_data)
        
        # Assert
        self.assertEqual(result.name, "张三")
        self.mock_repository.save.assert_called_once()
    
    def test_create_user_invalid_email(self):
        """测试创建用户邮箱无效"""
        user_data = {"name": "张三", "email": "invalid-email"}
        
        with self.assertRaises(ValidationException) as context:
            self.user_service.create_user(user_data)
        
        self.assertIn("邮箱格式不正确", str(context.exception))
    
    @patch('requests.get')
    def test_fetch_user_from_api(self, mock_get):
        """测试从API获取用户"""
        # Mock API响应
        mock_response = Mock()
        mock_response.json.return_value = {"id": 1, "name": "张三"}
        mock_response.status_code = 200
        mock_get.return_value = mock_response
        
        result = self.user_service.fetch_user_from_api(1)
        
        self.assertEqual(result["name"], "张三")
        mock_get.assert_called_once_with("https://api.example.com/users/1")

# pytest 风格测试
def test_calculate_age():
    """测试年龄计算"""
    from datetime import datetime
    birth_year = 1990
    expected_age = datetime.now().year - birth_year
    
    result = calculate_age(birth_year)
    
    assert result == expected_age

@pytest.fixture
def sample_user():
    """测试用户夹具"""
    return User(name="张三", email="zhang@example.com", age=25)

def test_user_validation(sample_user):
    """测试用户验证"""
    assert sample_user.is_valid()
    assert sample_user.age > 0
```

### 9.2 性能测试
```python
import time
import cProfile
import pstats
from functools import wraps

def profile_performance(func):
    """性能分析装饰器"""
    @wraps(func)
    def wrapper(*args, **kwargs):
        pr = cProfile.Profile()
        pr.enable()
        
        result = func(*args, **kwargs)
        
        pr.disable()
        stats = pstats.Stats(pr)
        stats.sort_stats('cumulative')
        stats.print_stats(10)  # 显示前10个最耗时的函数
        
        return result
    return wrapper

@profile_performance
def slow_function():
    """需要性能分析的函数"""
    time.sleep(0.1)
    return sum(range(100000))
```

## 10. 代码质量工具

### 10.1 代码质量工具配置
```toml
# pyproject.toml (推荐)
[build-system]
requires = ["setuptools>=45", "wheel"]
build-backend = "setuptools.build_meta"

[project]
name = "my-project"
version = "1.0.0"
description = "项目描述"
authors = [{name = "作者", email = "author@example.com"}]
dependencies = [
    "requests>=2.25.0",
    "pandas>=1.3.0",
    "pydantic>=1.8.0",
]

[project.optional-dependencies]
dev = [
    "pytest>=6.0",
    "black>=21.0",
    "flake8>=3.9",
    "mypy>=0.910",
]
```

### 10.2 工具使用
```bash
# 安装开发工具
pip install black isort flake8 mypy pytest

# 代码格式化
black .
isort .

# 代码检查
flake8 .
mypy .

# 运行测试
pytest
```

### 10.3 pre-commit 配置
```yaml
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/psf/black
    rev: 22.3.0
    hooks:
      - id: black
        language_version: python3.9

  - repo: https://github.com/pycqa/isort
    rev: 5.10.1
    hooks:
      - id: isort

  - repo: https://github.com/pycqa/flake8
    rev: 4.0.1
    hooks:
      - id: flake8

  - repo: https://github.com/pre-commit/mirrors-mypy
    rev: v0.950
    hooks:
      - id: mypy
```

## 11. 性能优化

### 11.1 内存优化
```python
import sys
from typing import Iterator

# 使用 __slots__ 减少内存占用
class User:
    __slots__ = ['name', 'email', 'age']
    
    def __init__(self, name: str, email: str, age: int):
        self.name = name
        self.email = email
        self.age = age

# 生成器替代列表（内存友好）
def process_large_dataset() -> Iterator[str]:
    """处理大数据集，使用生成器"""
    for i in range(1000000):
        yield f"item_{i}"

# 使用 itertools 进行高效迭代
from itertools import islice, chain, groupby

def batch_process(items: Iterator, batch_size: int = 100):
    """批量处理数据"""
    iterator = iter(items)
    while True:
        batch = list(islice(iterator, batch_size))
        if not batch:
            break
        yield batch
```

### 11.2 并发处理
```python
import asyncio
import aiohttp
from concurrent.futures import ThreadPoolExecutor, ProcessPoolExecutor
from typing import List

# 异步编程
async def fetch_user_async(session: aiohttp.ClientSession, user_id: int) -> dict:
    """异步获取用户信息"""
    async with session.get(f"https://api.example.com/users/{user_id}") as response:
        return await response.json()

async def fetch_multiple_users(user_ids: List[int]) -> List[dict]:
    """并发获取多个用户信息"""
    async with aiohttp.ClientSession() as session:
        tasks = [fetch_user_async(session, user_id) for user_id in user_ids]
        return await asyncio.gather(*tasks)

# 线程池
def cpu_intensive_task(n: int) -> int:
    """CPU密集型任务"""
    return sum(i * i for i in range(n))

def process_with_threads(numbers: List[int]) -> List[int]:
    """使用线程池处理"""
    with ThreadPoolExecutor(max_workers=4) as executor:
        results = list(executor.map(cpu_intensive_task, numbers))
    return results

# 进程池（CPU密集型任务）
def process_with_processes(numbers: List[int]) -> List[int]:
    """使用进程池处理CPU密集型任务"""
    with ProcessPoolExecutor(max_workers=4) as executor:
        results = list(executor.map(cpu_intensive_task, numbers))
    return results
```

## 12. Python 版本管理和现代特性

### 12.1 版本选择策略
```python
# 推荐使用的 Python 版本
# - Python 3.9+: 生产环境最低版本
# - Python 3.10+: 推荐版本（模式匹配等新特性）
# - Python 3.11+: 性能提升版本
# - Python 3.12+: 最新稳定版本

# 版本兼容性检查
import sys

if sys.version_info < (3, 9):
    raise RuntimeError("需要 Python 3.9 或更高版本")

# 使用 pyenv 管理多个 Python 版本
# pyenv install 3.11.5
# pyenv global 3.11.5
# pyenv local 3.10.12  # 项目特定版本
```

### 12.2 现代 Python 特性使用

#### Python 3.10+ 模式匹配
```python
def process_data(data):
    """使用模式匹配处理不同类型的数据"""
    match data:
        case {"type": "user", "id": user_id, "name": name}:
            return f"处理用户: {name} (ID: {user_id})"
        case {"type": "order", "id": order_id, "amount": amount}:
            return f"处理订单: {order_id}, 金额: {amount}"
        case {"type": "error", "message": msg}:
            raise ValueError(f"错误: {msg}")
        case _:
            return "未知数据类型"

# 模式匹配与类型
def handle_response(response):
    match response:
        case int() if response >= 200 and response < 300:
            return "成功"
        case int() if response >= 400:
            return "客户端错误"
        case int() if response >= 500:
            return "服务器错误"
        case str() as error_msg:
            return f"错误消息: {error_msg}"
```

#### Python 3.9+ 类型注解改进
```python
# 内置集合类型注解（无需从 typing 导入）
def process_users(users: list[dict[str, str]]) -> list[str]:
    return [user["name"] for user in users]

def get_config() -> dict[str, int | str]:
    return {"timeout": 30, "host": "localhost"}

# 联合类型简化
from typing import Union

# 旧方式
def old_way(value: Union[int, str]) -> str:
    return str(value)

# 新方式（Python 3.10+）
def new_way(value: int | str) -> str:
    return str(value)
```

#### Python 3.8+ 海象运算符
```python
# 在条件语句中赋值
def process_file(filename: str):
    if (content := read_file(filename)) is not None:
        return process_content(content)
    return None

# 在循环中使用
def read_chunks(file_path: str, chunk_size: int = 1024):
    with open(file_path, 'rb') as f:
        while (chunk := f.read(chunk_size)):
            yield chunk

# 在列表推导式中使用
def get_long_lines(text: str, min_length: int = 80):
    return [line for line in text.split('\n') 
            if (length := len(line)) > min_length]
```

### 12.3 性能优化现代技巧
```python
# 使用 functools.cache（Python 3.9+）
from functools import cache, lru_cache

@cache  # 无限制缓存
def fibonacci(n: int) -> int:
    if n < 2:
        return n
    return fibonacci(n-1) + fibonacci(n-2)

@lru_cache(maxsize=128)  # 有限制缓存
def expensive_computation(x: int, y: int) -> int:
    # 昂贵的计算
    return x ** y + y ** x

# 使用 dataclasses 和 slots
from dataclasses import dataclass

@dataclass
class Point:
    __slots__ = ['x', 'y']  # 减少内存使用
    x: float
    y: float
    
    def distance_from_origin(self) -> float:
        return (self.x ** 2 + self.y ** 2) ** 0.5
```

### 12.4 现代项目工具链
```bash
# 使用 ruff 替代 flake8 + isort（更快）
pip install ruff
ruff check .
ruff format .

# 使用 uv 替代 pip（更快的包管理器）
pip install uv
uv pip install requests
uv pip compile requirements.in

# 使用 pytest-xdist 并行测试
pip install pytest-xdist
pytest -n auto  # 自动使用所有CPU核心

# 使用 bandit 进行安全检查
pip install bandit
bandit -r src/
```

### 12.5 部署和打包现代化
```dockerfile
# 多阶段 Docker 构建
FROM python:3.11-slim as builder

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --user -r requirements.txt

FROM python:3.11-slim

WORKDIR /app
COPY --from=builder /root/.local /root/.local
COPY src/ ./src/

ENV PATH=/root/.local/bin:$PATH
CMD ["python", "-m", "src.main"]
```

```yaml
# GitHub Actions CI/CD
name: CI/CD
on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    strategy:
      matrix:
        python-version: ["3.9", "3.10", "3.11", "3.12"]
    
    steps:
    - uses: actions/checkout@v4
    - name: Set up Python
      uses: actions/setup-python@v4
      with:
        python-version: ${{ matrix.python-version }}
    
    - name: Install dependencies
      run: |
        python -m pip install --upgrade pip
        pip install -e ".[dev,test]"
    
    - name: Run tests
      run: |
        pytest --cov=src --cov-report=xml
    
    - name: Upload coverage
      uses: codecov/codecov-action@v3
```

---
**重要**: 遵循 PEP 8 规范和 Python 最佳实践，使用类型注解提高代码可读性和可维护性。积极采用现代 Python 特性提升开发效率和代码质量。