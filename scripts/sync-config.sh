#!/bin/bash
set -e

SOURCE="CLAUDE.md"
TARGETS=("AGENTS.md" ".trae/rules/project_rules.md")

for target in "${TARGETS[@]}"; do
    if [ ! -f "$target" ]; then
        echo "警告: $target 不存在，创建新文件"
    fi
    cp "$SOURCE" "$target"
    echo "已同步: $SOURCE -> $target"
done

echo "配置文件同步完成"
