# Upstream Changes（上游修改清单）

Apache-2.0 §4(b) 要求：修改过的文件必须携带显著修改声明。这份清单逐条记录本仓库对上游技能的改动：哪个文件、改了什么、为什么。每个改过的文件顶部还有一行声明，指回原仓库和这份清单。

## skills/mattpocock/：无修改

17 个技能逐字节原样收录自 [mattpocock/skills](https://github.com/mattpocock/skills) `d1478fc`（v1.3.2）。许可与版权见 `skills/mattpocock/LICENSE`。

## skills/harness/：基于 [simbajigege/book2skills](https://github.com/simbajigege/book2skills) `a707ed3`（2026-07-13）修改

改动的出发点：harness 侧只负责知识库搭建，凡是与 mattpocock 技能链重叠的职责（任务清单、决策记录、技术债），都改由它承担。

### harness-step1-create-agents-md（上游原名 `harness-step1-create-agent-md`）

| # | 修改 | 原因 |
|---|---|---|
| 1 | 目录名与 frontmatter `name` 对齐（`create-agent-md` → `create-agents-md`） | 消除目录名与技能名的不一致 |
| 2 | 删除 `docs/TECH_DECISIONS.md`；难逆转决策改写 ADR 到 `docs/adr/`（遵循 domain-modeling 技能的 ADR-FORMAT） | 决策记录只保留 ADR 一处 |
| 3 | 删除 `docs/exec-plans/`（backlog.md、tech-debt-tracker.md、active/、completed/）；待办与债务登记为 issue | 工作队列只保留 issue tracker 一处 |
| 4 | AGENTS.md 模板：知识库地图改为 6 行（新增 GLOSSARY.md、docs/adr/、issue tracker 行）；新增「会话流程」节 | 对齐 mattpocock 技能链的启动和收尾约定 |
| 5 | 修正"下一步"指向（上游曾把状态管理写作 step2 的职责），改为指向 `/setup-matt-pocock-skills` → step2 | 适配本组合的流水线顺序 |
| 6 | 未采用上游后续新增的 business-solution.md 业务层 | 有意取舍，让本组合聚焦工程流程 |
| 7 | README 安装命令指向本仓库（`dengpeng.zuo/agent-harness-kit`） | 适配本组合的分发；沿用上游路径会装到未修改版本 |

### harness-step2-fill-docs

| # | 修改 | 原因 |
|---|---|---|
| 1 | 前置条件收紧：要求 `/setup-matt-pocock-skills` 已运行（`docs/agents/issue-tracker.md` 与 `docs/agents/domain.md` 存在） | 这两份配置是本技能的硬依赖 |
| 2 | Step 4：从"写 TECH_DECISIONS.md"改为"难逆转决策写 ADR"，并 `Call the Skill tool with "domain-modeling"` 获取格式 | 决策记录只保留 ADR 一处（同上） |
| 3 | Step 6：从"写 tech-debt-tracker.md"改为"登记为 tracker issue"；删除 tracker 未配置时的兜底逻辑，改为硬前置停止 | 工作队列只保留 tracker 一处，不设兜底 |
| 4 | "下一步"指向改为 mattpocock 开发链（`/grill-with-docs` → `/to-spec` → `/to-tickets` → `/implement` → `/code-review`） | 本组合的知识库搭建只到 step2，之后直接进入开发层 |
| 5 | README 安装命令指向本仓库（`dengpeng.zuo/agent-harness-kit`） | 适配本组合的分发；沿用上游路径会装到未修改版本 |
