#!/bin/bash
set -e

SOURCE="CLAUDE.md"
TARGETS=("AGENTS.md")

for target in "${TARGETS[@]}"; do
    if [ -L "$target" ]; then
        rm -f "$target"
    fi
    ln -sf "$SOURCE" "$target"
    echo "已同步: $SOURCE -> $target"
done

echo "配置文件同步完成"
