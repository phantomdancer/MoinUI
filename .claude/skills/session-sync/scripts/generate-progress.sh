#!/bin/bash
# 生成并保存 session-progress.md
# 用法: ./generate-progress.sh [commit_count]

COMMIT_COUNT=${1:-10}
DATE=$(date +%Y-%m-%d)
LATEST_COMMIT=$(git log -1 --oneline 2>/dev/null || echo "无提交记录")
OUTPUT_FILE=".serena/memories/session-progress.md"

mkdir -p "$(dirname "$OUTPUT_FILE")"

{
cat << EOF
# 会话进度

## 最近更新
- 日期: $DATE
- 最新提交: $LATEST_COMMIT

## 当前任务
- [ ] 待定

## 近期提交 (git log)
EOF

git log --oneline -"$COMMIT_COUNT" 2>/dev/null | while read -r line; do
    echo "- $line"
done

cat << EOF

## 变更统计 (最近5次提交)
\`\`\`
EOF

git diff --stat HEAD~5 HEAD 2>/dev/null | tail -10 || echo "无足够提交历史"

cat << EOF
\`\`\`

## Git 状态
\`\`\`
EOF

git status --short 2>/dev/null || echo "非 git 仓库"

cat << EOF
\`\`\`

## 最近命令历史
EOF

if [ -f "$HOME/.claude/history.jsonl" ]; then
    tail -5 "$HOME/.claude/history.jsonl" | while read -r line; do
        display=$(echo "$line" | jq -r '.display // empty' 2>/dev/null)
        if [ -n "$display" ]; then
            echo "<command>"
            echo "$display"
            echo "</command>"
        fi
    done
fi

} > "$OUTPUT_FILE"

echo "已保存至 $OUTPUT_FILE"
