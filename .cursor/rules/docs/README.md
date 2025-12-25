# Docs 目录文档索引

> 本目录包含项目文档相关的模板、规范和指南

最近更新: 2025-10-11

---

## 📚 文档分类

### 核心规范（所有项目必读）
| 文档 | 说明 | 适用项目 | 优先级 |
|------|------|----------|--------|
| [adr-template.mdc](./adr-template.mdc) | 架构决策记录模板 | 所有项目 | P0 |
| [document.mdc](./document.mdc) | 文档体系与模板规范 | 所有项目 | P0 |

### 架构设计规范
| 文档 | 说明 | 适用项目 | 优先级 |
|------|------|----------|--------|
| [architecture-lightweight.mdc](./architecture-lightweight.mdc) | 轻量级架构文档模板 | 中小型项目（≤10人） | P1 |
| [module-design-guidelines.mdc](./module-design-guidelines.mdc) | 完整模块设计规范 | 大型项目（>10人） | P2 |

### 需求与设计
| 文档 | 说明 | 适用项目 | 优先级 |
|------|------|----------|--------|
| [feature-specification-guidelines.mdc](./feature-specification-guidelines.mdc) | 功能规格说明指南 | 中大型项目 | P1 |

---

## 🎯 快速选择指南

### 按项目规模选择

#### 小型项目（1-5人，< 3个月）
**必读**：
- ✅ [document.mdc](./document.mdc) - 了解文档体系
- ✅ [architecture-lightweight.mdc](./architecture-lightweight.mdc) - 30分钟快速版

**可选**：
- 📖 [adr-template.mdc](./adr-template.mdc) - 重要技术决策时使用

#### 中型项目（5-10人，3-6个月）
**必读**：
- ✅ [document.mdc](./document.mdc)
- ✅ [architecture-lightweight.mdc](./architecture-lightweight.mdc) - 2小时标准版
- ✅ [adr-template.mdc](./adr-template.mdc)

**推荐**：
- 📖 [feature-specification-guidelines.mdc](./feature-specification-guidelines.mdc) - 复杂功能开发

#### 大型项目（>10人，> 6个月）
**必读**：
- ✅ 所有文档

**重点**：
- 🔥 [module-design-guidelines.mdc](./module-design-guidelines.mdc)
- 🔥 [feature-specification-guidelines.mdc](./feature-specification-guidelines.mdc)
- 🔥 [adr-template.mdc](./adr-template.mdc)

---

## 📖 按文档类型选择

### 架构设计
```mermaid
flowchart TD
    A{项目规模?} -->|小型<br/>1-5人| B[architecture-lightweight.mdc<br/>30分钟快速版]
    A -->|中型<br/>5-10人| C[architecture-lightweight.mdc<br/>2小时标准版]
    A -->|大型<br/>>10人| D[module-design-guidelines.mdc<br/>完整版]
    
    B --> E[完成架构设计]
    C --> E
    D --> E
    
    style B fill:#86efac,stroke:#22c55e
    style C fill:#fde047,stroke:#eab308
    style D fill:#f87171,stroke:#dc2626
```

### 需求文档
- **简单功能**: 使用用户故事（User Story）即可
- **中等复杂度**: [feature-specification-guidelines.mdc](./feature-specification-guidelines.mdc) 简化版
- **高复杂度**: [feature-specification-guidelines.mdc](./feature-specification-guidelines.mdc) 完整版

### 决策记录
- **技术选型**: [adr-template.mdc](./adr-template.mdc)
- **架构变更**: [adr-template.mdc](./adr-template.mdc)
- **重要决策**: [adr-template.mdc](./adr-template.mdc)

---

## 🔗 文档关系图

```mermaid
graph TB
    A[产品需求 PRD] --> B[feature-specification-guidelines.mdc<br/>功能规格说明]
    B --> C[architecture-lightweight.mdc<br/>架构设计]
    B --> D[module-design-guidelines.mdc<br/>模块设计]
    C --> E[adr-template.mdc<br/>技术决策]
    D --> E
    C --> F[API文档]
    D --> F
    F --> G[代码实现]
    B --> H[测试用例]
    H --> I[验收测试]
    G --> I
    
    J[document.mdc<br/>文档规范] -.指导.-> B
    J -.指导.-> C
    J -.指导.-> D
    J -.指导.-> F
    
    style A fill:#dbeafe,stroke:#3b82f6
    style B fill:#fef3c7,stroke:#f59e0b
    style C fill:#dcfce7,stroke:#22c55e
    style D fill:#dcfce7,stroke:#22c55e
    style E fill:#fce7f3,stroke:#ec4899
    style J fill:#e0e7ff,stroke:#6366f1
```

---

## ✨ 文档特色

### adr-template.mdc
- ✅ 完整的ADR模板（基础版 + 简化版）
- ✅ 实际案例示例
- ✅ 团队协作流程
- ✅ 质量检查清单

### architecture-lightweight.mdc
- ✅ 3种填写模式（30分钟/2小时/1天）
- ✅ 10章节完整模板
- ✅ 丰富的Mermaid图表示例
- ✅ 实用的检查清单

### document.mdc
- ✅ 覆盖所有文档类型（README/API/CHANGELOG等）
- ✅ 可直接复制的完整模板
- ✅ 多语言代码示例
- ✅ 文档质量保证体系

### feature-specification-guidelines.mdc
- ✅ 从需求到验收的完整流程
- ✅ 用户注册功能完整示例
- ✅ 接口设计详细规范
- ✅ 监控运维指南

### module-design-guidelines.mdc
- ✅ 大型项目模块设计规范
- ✅ 七要素设计方法
- ✅ 流程与状态机设计
- ✅ NFR与风险管理

---

## 📝 使用建议

### 文档编写顺序
1. **项目启动**: 先读 [document.mdc](./document.mdc)，了解文档体系
2. **架构设计**: 使用 [architecture-lightweight.mdc](./architecture-lightweight.mdc)
3. **技术决策**: 使用 [adr-template.mdc](./adr-template.mdc) 记录重要决策
4. **功能开发**: 使用 [feature-specification-guidelines.mdc](./feature-specification-guidelines.mdc)
5. **大型模块**: 使用 [module-design-guidelines.mdc](./module-design-guidelines.mdc)

### 文档维护
- **定期更新**: 每季度回顾一次
- **版本管理**: 记录变更历史
- **团队评审**: 重要文档需要评审
- **持续改进**: 根据反馈优化

---

## 🎓 学习路径

### 新手路径（第1周）
1. 📖 [document.mdc](./document.mdc) - 30分钟了解文档体系
2. 📖 [architecture-lightweight.mdc](./architecture-lightweight.mdc) - 30分钟快速版
3. ✍️ 实践：为小项目编写架构文档

### 进阶路径（第1个月）
1. 📖 [adr-template.mdc](./adr-template.mdc) - 了解决策记录
2. 📖 [feature-specification-guidelines.mdc](./feature-specification-guidelines.mdc) - 学习功能设计
3. ✍️ 实践：为中型项目编写完整文档

### 高级路径（持续）
1. 📖 [module-design-guidelines.mdc](./module-design-guidelines.mdc) - 大型项目设计
2. 📖 参与团队文档评审
3. ✍️ 优化和完善文档规范

---

## 🛠️ 工具推荐

### 文档编辑
- **VSCode**: Markdown + Mermaid 插件
- **Typora**: 所见即所得编辑器
- **Notion**: 团队协作文档

### 图表工具
- **Mermaid**: 代码生成图表
- **Draw.io**: 在线流程图
- **PlantUML**: UML 图表

### 版本管理
- **Git**: 文档版本控制
- **GitBook**: 在线文档发布
- **Docusaurus**: 文档站点生成

---

## 📞 反馈与贡献

### 问题反馈
如果您发现文档问题或有改进建议，请：
1. 提交 Issue
2. 发起 Pull Request
3. 联系文档维护者

### 贡献指南
欢迎贡献！请遵循以下规范：
1. 遵循现有文档格式
2. 提供实际案例
3. 补充图表说明
4. 通过评审后合并

---

## 📊 文档统计

| 文档 | 大小 | 最后更新 | 状态 |
|------|------|----------|------|
| adr-template.mdc | ~400行 | 2025-10-11 | ✅ 完成 |
| architecture-lightweight.mdc | ~850行 | 2025-10-11 | ✅ 完成 |
| document.mdc | ~900行 | 2025-10-11 | ✅ 完成 |
| feature-specification-guidelines.mdc | ~3800行 | 2025-10-11 | ✅ 完成 |
| module-design-guidelines.mdc | ~528行 | 2025-09-18 | ✅ 良好 |

**总计**: 约6400+行文档内容（不含已移至tools目录的代码分析规范）

---

## 🔄 更新日志

### 2025-10-11
- ✅ 完全重写 adr-template.mdc
- ✅ 完全重写 architecture-lightweight.mdc
- ✅ 完全重写 document.mdc
- ✅ 完全重写 feature-specification-guidelines.mdc
- ✅ 新增 README.md 索引文档

### 历史版本
- 2025-09-18: 初始版本
- 2025-10-10: 路径修正

---

**维护者**: 技术团队  
**联系方式**: 见项目 README  
**最后更新**: 2025-10-11

