#!/usr/bin/env bash
# 把 skills/ 下的全部技能 symlink 进 harness 技能目录（Claude Code 与 Codex 通用）
# 重复运行安全：已存在的同名链接会被原子替换
set -euo pipefail

KIT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
TARGETS=("$HOME/.claude/skills" "$HOME/.agents/skills")

count=0
for target in "${TARGETS[@]}"; do
  mkdir -p "$target"
  for skill_dir in "$KIT_DIR"/skills/*/*/; do
    name="$(basename "$skill_dir")"
    ln -sfn "${skill_dir%/}" "$target/$name"
    echo "linked: $target/$name -> ${skill_dir%/}"
    count=$((count + 1))
  done
done

echo
echo "完成：$((count / 2)) 个技能 x ${#TARGETS[@]} 个目录。新开会话即可生效。"
