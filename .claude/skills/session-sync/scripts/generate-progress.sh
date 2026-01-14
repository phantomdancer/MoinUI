#!/bin/bash
# 生成并保存 session-progress.md
# 用法: ./generate-progress.sh [commit_count]

COMMIT_COUNT=${1:-10}
OUTPUT_FILE=".serena/memories/session-progress.md"

mkdir -p "$(dirname "$OUTPUT_FILE")"

{
cat << EOF
# 会话进度

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
