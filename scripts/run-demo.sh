#!/bin/bash
# 运行Demo应用，优先使用swift build产物，否则查找Xcode产物

SWIFT_BUILD_DEMO=".build/debug/Demo"
XCODE_DEMO=$(find ~/Library/Developer/Xcode/DerivedData -name "Demo" -path "*/MoinUi*/Build/Products/Debug/*" -type f 2>/dev/null | head -1)

if [ -x "$SWIFT_BUILD_DEMO" ]; then
    exec "$SWIFT_BUILD_DEMO"
elif [ -n "$XCODE_DEMO" ] && [ -x "$XCODE_DEMO" ]; then
    exec "$XCODE_DEMO"
else
    echo "Demo not found. Run 'swift build' first."
    exit 1
fi
