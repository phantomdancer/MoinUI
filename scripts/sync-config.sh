#!/bin/bash
set -e

SOURCE="CLAUDE.md"
TARGETS=("AGENTS.md" ".agent/rules/rule.md")

for target in "${TARGETS[@]}"; do
    cp -f "$SOURCE" "$target"
    echo "已同步: $SOURCE -> $target"
done

echo "配置文件同步完成"
