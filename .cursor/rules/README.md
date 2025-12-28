# Rules Index / 规范索引
最近更新: 2025-10-10

> 本目录按技术栈和用途分类维护 AI 协助时的角色、流程、编码、质量、安全、测试、可观测、文档等规则。回答/生成代码前应优先参考。

## 1. 目录结构

### 📁 languages/ - 编程语言专项规范
| 文件 | 作用 | 是否常驻 (alwaysApply) |
| ---- | ---- | ---------------------- |
| `csharp.mdc` | C#/.NET 专属实践 | ❌ |
| `go.mdc` | Go 语言专属实践 | ❌ |
| `java.mdc` | Java 专属实践 | ❌ |
| `python.mdc` | Python 专属实践 | ❌ |

### 📁 frameworks/ - 框架和前端规范
| 文件 | 作用 | 是否常驻 (alwaysApply) |
| ---- | ---- | ---------------------- |
| `frontend.mdc` | 前端工程规范骨架 | ❌ |
| `vue.mdc` | Vue 3 专属实践规范 | ❌ |
| `wechat-mini-program.mdc` | 微信小程序开发规范 | ❌ |

### 📁 architecture/ - 架构设计规范
| 文件 | 作用 | 是否常驻 (alwaysApply) |
| ---- | ---- | ---------------------- |
| `docs/architecture-lightweight.mdc` | 轻量级架构文档模板 | ❌ |
| `docs/module-design-guidelines.mdc` | 模块设计文档规范 | ❌ |

### 📁 docs/ - 文档和规范模板
| 文件 | 作用 | 是否常驻 (alwaysApply) |
| ---- | ---- | ---------------------- |
| `README.md` | 📑 **文档索引** - 快速导航指南 | ✅ 推荐首读 |
| `adr-template.mdc` | 架构决策记录模板（ADR） | ❌ |
| `architecture-lightweight.mdc` | 轻量级架构文档模板 | ❌ |
| `document.mdc` | 文档体系与模板规范（README/API/CHANGELOG等） | ❌ |
| `feature-specification-guidelines.mdc` | 功能规格说明指南（需求分析/功能设计/验收标准） | ❌ |
| `module-design-guidelines.mdc` | 模块设计文档规范（完整版） | ❌ |

### 📁 tools/ - 工具和实践规范
| 文件 | 作用 | 是否常驻 (alwaysApply) |
| ---- | ---- | ---------------------- |
| `coding-standards.mdc` | 跨语言通用编码规范 | ✅ |
| `database.mdc` | 数据库设计规范（表设计/索引/事务/外键约束等） | ✅ |
| `must.mdc` | 基本合规规则（最高优先级） | ✅ |
| `observability.mdc` | 可观测性实施指南 | ❌ |
| `quality.mdc` | 质量与自检清单 | ✅ |
| `role.mdc` | 角色定位与价值观 | ✅ |
| `security.mdc` | 安全基线与防护 | ❌ |
| `testing.mdc` | 测试策略与最佳实践 | ❌ |
| `workflow.mdc` | 工作流程与交付步骤 | ✅ |
| `code-analysis.mdc` | 代码分析专业场景规范（代码解构/业务分析/系统梳理） | ❌ |

说明：❌ 表示按需引用；若问题涉及对应领域（如安全/测试/代码分析）需手动拉入上下文。

## 1.1 按项目规模选择规约

### 小型项目（1-3人，1-3个月，<50万）
**必需**: `tools/must.mdc` + `tools/workflow.mdc` + `tools/coding-standards.mdc` + `tools/quality.mdc`  
**推荐**: 语言专项（核心章节）  
**可选**: `tools/security.mdc`（基础部分）  
**参考**: 查看 [中小型项目快速启动指南](./README-small-project.md)

### 中型项目（3-5人，3-6个月，50-100万）⭐
**必需**: 小型项目 + `docs/architecture-lightweight.mdc`  
**推荐**: `tools/security.mdc` + `docs/` 相关文档模板  
**可选**: `tools/observability.mdc`（基础监控）  
**参考**: 查看 [中小型项目快速启动指南](./README-small-project.md) ⭐推荐

### 大型项目（5+人，6+个月，100万+）
**必需**: 中型项目 + `docs/module-design-guidelines.mdc`  
**推荐**: `tools/observability.mdc` + `docs/adr-template.mdc`  
**可选**: `docs/feature-specification-guidelines.mdc`  
**参考**: 使用完整规约体系

## 2. 使用优先级（接入顺序）
1. `tools/must.mdc` 确保合规骨架（最高优先级）。
2. `tools/workflow.mdc` 明确当下所处阶段（需求→设计→实现→复盘）。
3. `tools/coding-standards.mdc` 保障实现质量（命名/异常/日志/结构）。
4. 根据主题附加：安全(`tools/security.mdc`)、测试(`tools/testing.mdc`)、可观测(`tools/observability.mdc`)。
5. 输出涉及架构/接口/文档 → 参考 `docs/` 目录，完成后自检 `tools/quality.mdc`。

### 层级关系 (Dependency Hierarchy)
```
tools/must (最高优先级)
	│
	├─ tools/role + tools/workflow ─┐
	│                               │
	├─ tools/quality                │
	│                               │
	└─ tools/coding-standards + tools/database (基础编码规范)
			│
			├─ languages/: csharp / go / java / python
			├─ frameworks/: vue / frontend / wechat-mini-program
			├─ domain topics: tools/security / tools/testing / tools/observability
			└─ documentation: docs/ (引用上层成果)
```
原则：自上而下单向引用；专题文件可引用基础规范，反向不建立硬链接，避免循环与冗余。

## 3. 快速检查清单（回答前 30 秒）
- [ ] 需求是否缺少边界/异常说明？
- [ ] 是否选择了最小可行方案？
- [ ] 代码是否需引用语言专项（Python/Go/Java/C#）？
- [ ] 是否涉及安全/可观测/文档？对应文件是否引用？
- [ ] 是否需要更新 README 或新增 ADR？

## 4. 文档质量自检清单
### 架构文档质量检查
- [ ] **范围定位**：目标量化、边界明确、非目标列出
- [ ] **用例时序**：至少1个主路径+1个异常路径，标注超时/重试/幂等
- [ ] **部署拓扑**：C4图完整，标注扩展点/单点风险/故障域
- [ ] **组件方法**：关键方法有签名/前后置条件/幂等策略
- [ ] **NFR指标**：性能/可用性/一致性有具体数值目标
- [ ] **风险缓解**：每个风险有监控指标和触发阈值
- [ ] **术语一致**：使用统一术语表，避免自创概念

### 模块文档质量检查  
- [ ] **角色用例**：包含频率和优先级，P0用例有完整时序
- [ ] **领域模型**：实体有职责/字段/不变量，关系图清晰
- [ ] **接口契约**：API表包含幂等键/超时，事件有幂等字段
- [ ] **错误处理**：分类明确，重试策略具体，幂等点标注
- [ ] **监控可观测**：指标有目标值，span命名规范，日志结构化
- [ ] **数据存储**：表结构完整，索引合理，分区/归档策略明确

### 通用文档质量检查
- [ ] **可量化**：避免"高性能"等模糊词，使用具体数值
- [ ] **可验证**：所有声明都有验证方式或监控手段  
- [ ] **可操作**：读者能根据文档执行具体动作
- [ ] **图文并茂**：关键流程有Mermaid图，复杂表格结构化
- [ ] **版本管理**：状态/负责人/更新时间准确，变更记录完整

## 5. 变更策略
- 新增/修改规则：需更新本索引并在相关文件加"变更日期"或"迁移说明"。
- 最近更新：本目录文件若发生重要调整，请在文件头部或首段附"最近更新: YYYY-MM-DD"。
- 废弃规则：在原文件首部标记 `Deprecated` 并给出替代文件。
- 大型重构：先增量引入新文件 → 双轨期 → 清理旧文件。

## 6. 维护责任
- 若引入新领域文件，需：目标 + 范围 + 最小示例 + 与现有文件关系。
- 定期（每月）审查是否有冗余或交叉重复内容。

---
任何回答若出现规范冲突：以 `tools/must.mdc` 为最高优先级 → 其次 `tools/workflow.mdc` 与 `tools/coding-standards.mdc` → 其余文件作为补充。