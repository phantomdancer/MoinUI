#!/bin/bash
set -e

SOURCE="CLAUDE.md"
TARGETS=("AGENTS.md" ".agent/rules/rule.md")

# 确保在脚本所在目录执行
cd "$(dirname "$0")" || exit 1
cd ..  # 返回到项目根目录

for target in "${TARGETS[@]}"; do
    ln -sf "$SOURCE" "$target"
    echo "已创建软链接: $SOURCE -> $target"
done

echo "配置文件同步完成"
