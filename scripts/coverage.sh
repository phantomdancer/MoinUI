#!/bin/bash

# Coverage report script for MoinUI

BINARY=".build/debug/MoinUIPackageTests.xctest/Contents/MacOS/MoinUIPackageTests"
PROFDATA=".build/debug/codecov/default.profdata"

if [ ! -f "$PROFDATA" ]; then
    echo "❌ 覆盖率数据不存在，请先运行 swift test --enable-code-coverage"
    exit 1
fi

echo ""
echo "📊 MoinUI 测试覆盖率报告"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Get coverage data and format it
xcrun llvm-cov report "$BINARY" \
    --instr-profile="$PROFDATA" \
    --sources Sources/MoinUI 2>/dev/null | \
while IFS= read -r line; do
    # Skip empty lines
    if [ -z "$line" ]; then
        continue
    fi

    # Check if it's the header line
    if [[ "$line" == *"Filename"* ]]; then
        printf "%-40s %8s %8s %8s\n" "文件" "行数" "未覆盖" "覆盖率"
        echo "────────────────────────────────────────────────────────────────────"
        continue
    fi

    # Skip separator lines
    if [[ "$line" == *"---"* ]]; then
        continue
    fi

    # Parse data lines
    filename=$(echo "$line" | awk '{print $1}')

    # Skip if no filename
    if [ -z "$filename" ]; then
        continue
    fi

    # Extract lines coverage (columns 8, 9, 10 are Lines, Missed Lines, Cover)
    lines=$(echo "$line" | awk '{print $8}')
    missed=$(echo "$line" | awk '{print $9}')
    cover=$(echo "$line" | awk '{print $10}')

    # Shorten filename
    shortname=$(basename "$filename")

    # Check if it's TOTAL line
    if [[ "$filename" == "TOTAL" ]]; then
        echo "────────────────────────────────────────────────────────────────────"
        printf "%-40s %8s %8s %8s\n" "总计" "$lines" "$missed" "$cover"
    else
        printf "%-40s %8s %8s %8s\n" "$shortname" "$lines" "$missed" "$cover"
    fi
done

echo ""
echo "💡 提示: 运行 pnpm test:coverage:html 可生成详细HTML报告"
echo ""
