---
name: harness-step1-create-agents-md
description: |
  Harness Engineering 第一阶段：扫描现有项目，生成 AGENTS.md（目录文件）和完整的 docs/ 知识库结构。
  
  当用户想要"为项目添加 agent 支持"、"让 AI 更好地理解我的项目"、"开始 harness engineering"、
  "创建 AGENTS.md"、"搭建 agent 文档结构"、"让 Claude Code 更好地工作"时，立即使用此 skill。
  
  也适用于用户说"帮我把项目文档整理好给 agent 用"、"我想开始用 AI agent 开发"等场景。
---

> **Modified** from [simbajigege/book2skills](https://github.com/simbajigege/book2skills) (Apache-2.0) by dengpeng.zuo — see [UPSTREAM-CHANGES.md](../../UPSTREAM-CHANGES.md) for the full change list.

# Harness Step 1: 创建 AGENTS.md 与 docs/ 知识库

## 目标

为项目建立 agent 可读的知识库地基：
- 一份简短的 `AGENTS.md`（~100 行，作为"目录"而非百科全书）
- 一套 `docs/` 目录结构，存放真正的知识

**核心原则**：agent 看不到的东西就不存在。所有架构决策、命名约定、技术选型，必须以文件形式存在于仓库中。

---

## 执行步骤

### Step 1：扫描项目

按顺序收集项目信息，**已知信息跳过，不要重复提问**：

```bash
# 1. 项目根目录结构（2层）
find . -maxdepth 2 -not -path '*/node_modules/*' -not -path '*/.git/*' \
  -not -path '*/__pycache__/*' -not -path '*/dist/*' -not -path '*/.next/*' | sort

# 2. 识别技术栈
cat package.json 2>/dev/null || cat pyproject.toml 2>/dev/null || \
  cat go.mod 2>/dev/null || cat Cargo.toml 2>/dev/null || echo "未找到包管理文件"

# 3. 查看是否已有文档
ls -la *.md 2>/dev/null; ls -la docs/ 2>/dev/null

# 4. 查看 README（如有）
head -80 README.md 2>/dev/null || head -80 readme.md 2>/dev/null
```

从扫描结果中提取：
- **项目名称和用途**（从 README 或 package.json）
- **技术栈**（语言、框架、主要依赖）
- **目录结构**（主要模块划分）
- **已有文档**（避免重复，复用现有内容）

### Step 2：生成 docs/ 目录结构

创建以下文件（内容根据扫描结果填写，不要留空占位符）：

**必须创建的文件：**

```
AGENTS.md                    ← 目录文件，~100行
docs/
├── ARCHITECTURE.md          ← 模块划分、依赖关系
├── CONVENTIONS.md           ← 命名规则、代码风格
└── QUALITY.md               ← 验收标准、完成定义
```

**不在此处创建**（它们归 mattpocock 技能链管，避免双轨）：

- `GLOSSARY.md` 与 `docs/adr/`（ADR）：由 `grill-with-docs` / `domain-modeling` 技能维护。难逆转的技术决策写成 ADR，不单独建 TECH_DECISIONS.md
- 工作队列：issue tracker 由 `setup-matt-pocock-skills` 配置，布局见 `docs/agents/issue-tracker.md`。待开发功能和技术债务都登记为 issue，不建 backlog.md / tech-debt-tracker.md

**可选创建（根据项目实际情况判断）：**

```
docs/
├── design-docs/             ← 有复杂设计决策时创建
├── product-specs/           ← 有产品规格时创建
└── references/              ← 有外部文档需要本地化时创建
```

### Step 3：写 AGENTS.md

严格遵守以下格式，控制在 100 行以内：

```markdown
# [项目名称] — Agent 工作指南

## 这是什么项目
[1-3句话：项目用途、核心功能、服务对象]

## 快速定向
- **我在哪个目录？** 运行 `pwd` 确认工作目录
- **技术栈**：[语言] + [框架] + [主要工具]
- **入口文件**：[主要入口，如 src/main.ts、app/main.py]
- **启动命令**：[如何启动开发服务器]
- **测试命令**：[如何跑测试]

## 知识库地图
在做任何修改前，先阅读相关文档：

| 我想了解... | 去读这个文件 |
|------------|-------------|
| 整体架构、模块划分 | `docs/ARCHITECTURE.md` |
| 命名规则、代码风格 | `docs/CONVENTIONS.md` |
| 什么叫"完成" | `docs/QUALITY.md` |
| 领域词汇 | `GLOSSARY.md`（grill-with-docs / domain-modeling 维护） |
| 决策记录 | `docs/adr/`（难逆转的决策写 ADR） |
| 当前工作队列（含待办与技术债） | issue tracker，见 `docs/agents/issue-tracker.md`（由 setup-matt-pocock-skills 配置） |

## 会话流程
开始一个 session，按顺序：
1. `git log --oneline -10` 恢复上下文
2. 从 issue tracker 领取 `ready-for-agent` 的 issue 开始；feature/大改动走 implement 流程（tdd + code-review），环境问题会在第一轮测试时暴露，届时先修复再继续

完成一个 issue 后，按顺序：
1. 执行票面验收步骤，确认通过
2. git commit，格式：`type(scope): 做了什么，遗留了什么（如有）`
3. 按 tracker doc 的方式关闭该 issue

**禁止**：跳过验收自行判断完成；在 tracker 之外另立任务清单（tasks.md 等）双轨。

## 工作规范
1. **改之前先读**：修改任何模块前，先读对应的架构文档
2. **完成即提交**：每个功能完成后立即 git commit，写清楚做了什么
3. **更新文档**：如果你的修改影响了架构或约定，同步更新 docs/
4. **不要猜**：看不懂的地方先读文档，文档没有再问

## 禁止事项
[根据项目实际情况填写，例如：]
- 不要直接修改 `generated/` 目录下的文件（自动生成）
- 不要跳过测试直接合并
- 不要在 service 层引用 UI 组件（见 docs/ARCHITECTURE.md）
```

### Step 4：写各个 docs/ 文件

每个文件的内容要求：

**`docs/ARCHITECTURE.md`**
- 模块/包的划分和职责
- 依赖方向规则（哪层能引用哪层）
- 主要数据流
- 不要写实现细节，写"是什么"和"为什么这样分"

**`docs/CONVENTIONS.md`**
- 文件命名规则
- 变量/函数/类命名规则
- 目录组织规则
- 注释风格
- 任何团队约定俗成的习惯

**`docs/QUALITY.md`**
- 一个功能算"完成"的标准（Definition of Done）
- 代码审查检查清单
- 测试覆盖要求
- 性能基准（如果有）

**技术选型与技术债的去向**（不在 docs/ 建文件）：
- 难逆转的选型/架构决策：写成 ADR 放 `docs/adr/`（格式遵循 domain-modeling 技能的 ADR-FORMAT），扫描时无法判断原因的标注「待补充」并汇总给用户
- 待开发功能、已知技术债务：登记为 issue 到 tracker（按 `docs/agents/issue-tracker.md` 的方式）；tracker 尚未配置时，汇总在完成摘要里，由用户配置后登记

---

## 质量检验

生成完成后，自检以下问题：

- [ ] AGENTS.md 是否控制在 150 行以内？
- [ ] AGENTS.md 里是否有具体的启动/测试命令（而非"见文档"）？
- [ ] docs/ 里的文件是否有实际内容，而非空占位符？
- [ ] 无法判断的决策是否标注了"待补充"，且选型理由指向 ADR 而非新清单文件？
- [ ] 目录表里的每个链接是否对应实际存在的文件（issue tracker 行除外）？

---

## 完成后告知用户

输出一个简短摘要：
1. 创建了哪些文件
2. 哪些内容是从项目扫描中推断的（可能需要人工核实）
3. 哪些字段需要用户手动补充（标注了"待补充"的地方）
4. 下一步：先运行 /setup-matt-pocock-skills，配置 issue tracker（工作队列）和领域文档布局（GLOSSARY/ADR 位置），它会把 `## Agent skills` 块追加到刚生成的 AGENTS.md；之后再运行 `harness-step2-fill-docs` 填充 docs/ 的实质内容。地基完成后，开发走 mattpocock 技能链：/grill-with-docs → /to-spec → /to-tickets → /implement → /code-review
