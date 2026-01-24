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

# 同步 Skills 目录
SKILL_SOURCE=".claude/skills/notify-bark"
SKILL_TARGET=".agent/skills/notify-bark"

if [ -d "$SKILL_SOURCE" ]; then
    mkdir -p "$(dirname "$SKILL_TARGET")"
    rm -rf "$SKILL_TARGET" # 删除旧链接或目录
    
    target_dir=$(dirname "$SKILL_TARGET")
    rel_source=$(python3 -c "import os.path; print(os.path.relpath('$SKILL_SOURCE', '$target_dir'))")
    
    ln -s "$rel_source" "$SKILL_TARGET"
    echo "已同步目录: $rel_source -> $SKILL_TARGET"
else
    echo "警告: 源目录 $SKILL_SOURCE 不存在"
fi

echo "配置文件同步完成"
