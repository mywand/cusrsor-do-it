# cusrsor-do-it
cusrsor最佳实践

## 设置方式

### 前置条件
1. 确保已安装 Cursor 编辑器
2. 下载或克隆本仓库到本地

### Windows 设置方式

1. **打开 PowerShell 或 CMD（需要管理员权限）**
   
2. **进入你的项目目录**
   ```powershell
   cd D:\your-project-path
   ```

3. **创建符号链接**
   ```powershell
   # 方式一：使用 mklink（推荐）
   mklink /D ".cursor" "D:\tryc\docs\mydemo\cusrsor-do-it\.cursor"
   
   # 方式二：使用 PowerShell 命令
   New-Item -ItemType SymbolicLink -Path ".cursor" -Target "D:\tryc\docs\mydemo\cusrsor-do-it\.cursor"
   ```

4. **验证设置**
   ```powershell
   # 检查链接是否创建成功
   dir .cursor
   # 或
   ls -la .cursor
   ```

### Linux / macOS 设置方式

1. **进入你的项目目录**
   ```bash
   cd /path/to/your-project
   ```

2. **创建符号链接**
   ```bash
   ln -s /path/to/cusrsor-do-it/.cursor .cursor
   ```

3. **验证设置**
   ```bash
   ls -la .cursor
   ```

### 在 Cursor 中启用规则

设置完成后，Cursor 会自动识别 `.cursor/rules/` 目录下的规则文件。这些规则会在以下场景自动应用：

- **AI 对话**：在聊天中自动应用相关规范
- **代码生成**：生成代码时遵循编码规范
- **代码补全**：补全建议符合项目规范

### 验证规则是否生效

1. 在 Cursor 中打开项目
2. 在 AI 对话中询问："请按照项目规范生成一个 Java 类"
3. 检查生成的代码是否符合 `.cursor/rules/languages/java.mdc` 中的规范

### 注意事项

- ⚠️ **符号链接路径**：确保使用**绝对路径**创建符号链接
- ⚠️ **权限要求**：Windows 创建符号链接需要管理员权限
- ⚠️ **路径分隔符**：Windows 使用反斜杠 `\`，Linux/macOS 使用正斜杠 `/`
- ✅ **多项目共享**：一个规约仓库可以被多个项目共享使用

## Cursor 设置规约文档路径

所有规约文档位于 `.cursor/rules/` 目录下，按类别组织：

### 文档规范 (`docs/`)
- `.cursor/rules/docs/adr-template.mdc` - 架构决策记录模板
- `.cursor/rules/docs/architecture-lightweight.mdc` - 轻量级架构文档模板
- `.cursor/rules/docs/document.mdc` - 文档体系与模板规范
- `.cursor/rules/docs/feature-specification-guidelines.mdc` - 功能说明文档规约
- `.cursor/rules/docs/module-design-guidelines.mdc` - 模块设计文档规范
- `.cursor/rules/docs/module-engineering-practices.mdc` - 模块设计工程实践指南
- `.cursor/rules/docs/module-quality-assurance.mdc` - 模块设计质量保障指南
- `.cursor/rules/docs/module-seven-elements.mdc` - 模块设计七要素详细规范

### 框架规范 (`frameworks/`)
- `.cursor/rules/frameworks/frontend.mdc` - 前端工程规范骨架
- `.cursor/rules/frameworks/vue.mdc` - Vue 3 专属实践规范
- `.cursor/rules/frameworks/wechat-mini-program.mdc` - 微信小程序开发规范

### 语言规范 (`languages/`)
- `.cursor/rules/languages/csharp.mdc` - C#/.NET 专属实践规范
- `.cursor/rules/languages/go.mdc` - Go 项目编码规范
- `.cursor/rules/languages/java.mdc` - Java 编码与工程规约
- `.cursor/rules/languages/python.mdc` - Python 专属实践规范

### 工具规范 (`tools/`)
- `.cursor/rules/tools/code-analysis.mdc` - 代码分析专业场景规范
- `.cursor/rules/tools/java-testing.mdc` - Java测试用例生成规约
- `.cursor/rules/tools/observability.mdc` - 可观测性规范（日志、指标、追踪、告警）
- `.cursor/rules/tools/testing.mdc` - 测试策略与最佳实践

### 查看规约文档
在 Cursor 中，这些规约会自动应用到 AI 助手的响应中。你也可以直接查看这些 `.mdc` 文件了解详细规范。

欢迎一起完善。