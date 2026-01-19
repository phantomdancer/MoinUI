#!/bin/bash
set -e

SOURCE="CLAUDE.md"
TARGETS=("AGENTS.md" ".agent/rules/rule.md")

# 确保在脚本所在目录执行
cd "$(dirname "$0")" || exit 1
cd ..  # 返回到项目根目录

for target in "${TARGETS[@]}"; do
    # 确保目标目录存在
    mkdir -p "$(dirname "$target")"
    
    # 计算相对路径
    target_dir=$(dirname "$target")
    # 使用 Python 计算相对路径 (MacOS 兼容)
    rel_source=$(python3 -c "import os.path; print(os.path.relpath('$SOURCE', '$target_dir'))")
    
    ln -sf "$rel_source" "$target"
    echo "已创建软链接: $rel_source -> $target"
done

echo "配置文件同步完成"
