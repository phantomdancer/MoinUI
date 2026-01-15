#!/bin/bash
set -e

SOURCE="CLAUDE.md"
TARGETS=("AGENTS.md" ".agent/rules/rule.md")

for target in "${TARGETS[@]}"; do
    ln -sf "$(pwd)/$SOURCE" "$target"
    echo "已创建软链接: $SOURCE -> $target"
done

echo "配置文件同步完成"
