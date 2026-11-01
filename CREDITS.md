# Credits & Attribution（致谢）

这个项目是"站在两个优秀肩膀上"的组合。没有他们，就没有这个仓库。

## Matt Pocock — mattpocock/skills（MIT）

- 上游仓库：<https://github.com/mattpocock/skills>
- 作者网站与文档：<https://www.aihero.dev>
- 本仓库收录：`skills/mattpocock/` 下的 17 个技能，**逐字节原样**收录，未做任何修改
- 许可证：MIT（全文见 `skills/mattpocock/LICENSE`，版权声明未动）
- 收录版本：commit `d1478fc`（v1.3.2）

这些技能覆盖 idea → ship 的完整主流程：`grilling` 访谈原语、`grill-with-docs`、
`to-spec` → `to-tickets` → `implement(-spec)`、`tdd`、`code-review`、`wayfinder`、
`prototype`、`diagnosing-bugs` 等。本组合的**开发层**完全由它们承担，一字未改。

如果本仓库对你有用，请顺路给上游一个 star——这才是对作者最实在的支持。

## simbajigege — book2skills（Apache-2.0）

- 上游仓库：<https://github.com/simbajigege/book2skills>
- 本仓库收录：`skills/harness/` 下的 2 个技能，**有修改**（声明见
  [UPSTREAM-CHANGES.md](UPSTREAM-CHANGES.md) 与各文件顶部的 "Modified" 标注）
- 许可证：Apache-2.0（原文保留在各技能目录的 `LICENSE` 文件中，版权声明未动）
- 收录版本：harness-step1 / harness-step2 内容对应上游 commit `a707ed3`（2026-07-13）

这些技能承担本组合的**环境层**：扫描项目、生成 AGENTS.md 与 `docs/` 知识库。
原作的几条设计是整个组合的地基，全部原样保留：

- "agent 看不到的东西就不存在"
- 推断的内容标注来源，无法确定的标注「待补充」，绝不编造
- 断言组件关系前必须用 grep 验证 import

## 本仓库的取舍原则

1. 只在环境层做修改；开发层的 17 个技能零改动
2. 凡与 mattpocock 侧重叠的职责（任务清单、决策记录、债务管理），一律让位，
   避免双轨——这是本组合存在的理由，也记录在 [UPSTREAM-CHANGES.md](UPSTREAM-CHANGES.md)
3. 修改过的文件顶部保留指向上游与修改清单的声明
4. 项目名与品牌不使用任何原作者名义

## 维护者

- **dengpeng.zuo** — 组合、取舍与适配。本仓库中属于他的新内容：
  README、NOTICE、CREDITS、UPSTREAM-CHANGES、`scripts/install.sh`，
  以及 `skills/harness/` 内的全部修改。
