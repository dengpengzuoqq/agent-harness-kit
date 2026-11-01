# agent-harness-kit

一套装给 Claude Code / Codex 的技能组合：两个技能帮项目搭好 agent 知识库，十七个技能负责从想法到合并的开发流程。

> 技能来自两位作者。开发层的 17 个技能原样取自 [mattpocock/skills](https://github.com/mattpocock/skills)（MIT）；环境层的 2 个技能改编自 [simbajigege/book2skills](https://github.com/simbajigege/book2skills)（Apache-2.0）。如果这套东西对你有用，请先去给两位上游点 star。
> 收录版本：mattpocock/skills v1.3.2（commit `d1478fc`）；book2skills 的 harness 技能对应 commit `a707ed3`（2026-07-13）。
> 归属细节见 [CREDITS.md](CREDITS.md)，逐条修改清单见 [UPSTREAM-CHANGES.md](UPSTREAM-CHANGES.md)。

## 为什么有这个仓库

用 agent 开发，你大概遇到过两件事：换个 session，它就不认识你的项目；同一次对话里没有流程约束，写着写着方向就散。

两个问题各有现成方案，但直接混用会撞车。任务清单、决策记录、技术债，每样都有两个存放点。你问 agent"接下来干什么"，它手里会有三个不同来源的答案。

这个仓库把两边拼好，规矩只有一条：harness 侧只管知识库搭建（AGENTS.md 和 docs/），流程类的职责全部交给 mattpocock 侧的技能链。任务看 tracker，决策看 ADR，词汇看 GLOSSARY.md，每样只有一处。

## 流水线

```
环境层（每个项目只跑一次）
  harness-step1              扫描项目 → AGENTS.md（知识库地图 + 会话流程）+ docs/ 骨架
  /setup-matt-pocock-skills  配置 issue tracker + 领域文档布局（GLOSSARY/ADR 放哪）
  harness-step2              深读代码填充 docs/；决策 → ADR；债务/待办 → tracker issue

开发层（每个 feature 都走）
  /grill-with-docs           访谈打磨想法，随手维护 GLOSSARY.md 与 ADR
  /to-spec                   会话沉淀为 spec，发布到 tracker
  /to-tickets                spec 拆成带阻塞边的 ticket（打 ready-for-agent 标签）
  /implement                 按 ticket 开发：tdd + code-review → 关票
```

环境层的产出就是开发层的输入。AGENTS.md 和 docs/ 是每个开发技能开工前要读的上下文，issue tracker 是领任务和交活的唯一入口。

## 安装

```bash
git clone https://github.com/dengpeng.zuo/agent-harness-kit.git
cd agent-harness-kit
./scripts/install.sh
```

`install.sh` 会把 `skills/` 下的全部技能 symlink 进 `~/.claude/skills` 和
`~/.agents/skills`（Claude Code 与 Codex 通用；symlink 意味着 `git pull`
即可更新）。也可以手动把各技能目录拷进任一技能目录。

## 使用顺序

```
1. 在目标项目里运行 harness-step1          （"为项目添加 agent 支持"）
2. 运行 /setup-matt-pocock-skills          （配置 tracker 与领域文档布局）
3. 运行 harness-step2                      （"填充文档内容"）
4. 开始开发：/grill-with-docs → /to-spec → /to-tickets → /implement
```

说明：本组合未收录上游的 `triage` 技能，`setup-matt-pocock-skills` 会自动
探测并跳过相关配置，属正常现象。

## 包含的技能（19 个）

| 技能 | 来源 | 修改 |
|---|---|---|
| `harness-step1-create-agents-md` | book2skills（Apache-2.0） | 有（见 UPSTREAM-CHANGES.md） |
| `harness-step2-fill-docs` | book2skills（Apache-2.0） | 有（见 UPSTREAM-CHANGES.md） |
| `grilling` / `grill-with-docs` / `handoff` / `writing-for-agents` | mattpocock/skills（MIT） | 无 |
| `to-spec` / `to-tickets` / `implement` / `implement-spec` | mattpocock/skills（MIT） | 无 |
| `tdd` / `code-review` / `diagnosing-bugs` / `research` / `prototype` | mattpocock/skills（MIT） | 无 |
| `domain-modeling` / `codebase-design` / `wayfinder` | mattpocock/skills（MIT） | 无 |
| `setup-matt-pocock-skills` | mattpocock/skills（MIT） | 无 |

上游还有更多本组合未收录的技能（`ask-matt`、`retro`、`triage`、`wizard` 等），
请直接到两位上游的仓库查看。

## 我改了什么

对上游技能的每一条修改都记录在 [UPSTREAM-CHANGES.md](UPSTREAM-CHANGES.md)：改了哪个文件，为什么改。每个改过的文件顶部都有一行声明，指向原仓库和这份清单（Apache-2.0 §4(b) 的要求，也是对原作者的交代）。

## 许可证

- 本仓库的组合与新增内容：[Apache-2.0](LICENSE)（Copyright 2026 dengpeng.zuo）
- `skills/mattpocock/`：MIT（Copyright (c) 2026 Matt Pocock，见目录内 LICENSE）
- `skills/harness/`：Apache-2.0（Copyright 2026 simbajigege，各目录内保留原 LICENSE）
