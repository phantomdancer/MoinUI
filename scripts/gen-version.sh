#!/bin/bash
# 从package.json读取版本号并生成Version.swift

VERSION=$(grep '"version"' package.json | sed 's/.*"version": *"\([^"]*\)".*/\1/')

cat > Sources/MoinUI/Utils/Version.swift << EOF
// 自动生成，勿手动修改
public let MoinUIVersion = "$VERSION"
EOF

echo "Generated Version.swift with version: $VERSION"
