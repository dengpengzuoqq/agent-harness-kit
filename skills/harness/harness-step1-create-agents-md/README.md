# Harness Step 1 — Create AGENTS.md & docs/

> **Modified** from [simbajigege/book2skills](https://github.com/simbajigege/book2skills) (Apache-2.0) by dengpeng.zuo — see [UPSTREAM-CHANGES.md](../../UPSTREAM-CHANGES.md) for the full change list.

Give any Claude Code agent a permanent memory of your project — in one shot.

This skill scans your codebase and produces two things: a concise `AGENTS.md` that acts as a table of contents, and a `docs/` knowledge base (ARCHITECTURE, CONVENTIONS, QUALITY). Every future agent session reads these files instead of rediscovering the project from scratch.

## What It Does

- Scans project structure (up to 3 levels), tech stack, entry points, and existing docs
- Generates `AGENTS.md` (~100 lines) — the single file an agent reads first in every session
- Creates `docs/ARCHITECTURE.md`, `docs/CONVENTIONS.md`, `docs/QUALITY.md`
- Points decision records at ADRs (`docs/adr/`, maintained via the domain-modeling skill) and the work queue at the issue tracker (configured by `setup-matt-pocock-skills`) instead of local list files
- Marks anything it can't infer as "待补充" (to be filled in by a human) — never invents facts

## When to Use It

Use this skill whenever you want to:
- Add agent support to an existing project for the first time
- Help Claude Code understand your codebase without repeated explanations
- Start "Harness Engineering" — building a permanent agent knowledge layer
- Create AGENTS.md, set up docs/, or make AI work better in your repo

Trigger phrases: "为项目添加 agent 支持", "创建 AGENTS.md", "让 Claude Code 更好地工作", "开始 harness engineering", "搭建 agent 文档结构", "add agent support", "create AGENTS.md".

## Installation

### Option 1 — CLI (recommended)

```bash
npx skills add dengpeng.zuo/agent-harness-kit/skills/harness/harness-step1-create-agents-md
```

### Option 2 — Manual upload

1. Download the skill folder (or clone this repo).
2. In Claude.ai, go to **Settings → Skills** and upload the folder.
3. The skill will appear in your available skills list.

## Prerequisites

None. This is the **first step** in the Harness Engineering pipeline.

After running this skill, continue with:
- **`/setup-matt-pocock-skills`**: configure the issue tracker (the single work queue) and the domain doc layout (where GLOSSARY.md and ADRs live). It appends an `## Agent skills` block to the AGENTS.md this skill generated.
- **Step 2** (`harness-step2-fill-docs`): Deep-read the code and fill in the docs — ADRs follow the configured domain layout, and debt findings register straight onto the configured tracker.

Then develop with the mattpocock flow: `grill-with-docs` → `to-spec` → `to-tickets` → `implement` → `code-review`.

## File Structure

```
harness-step1-create-agents-md/
├── SKILL.md          # Main skill instructions
└── README.md         # This file
```

## License

Apache 2.0 — Original work. See LICENSE.
