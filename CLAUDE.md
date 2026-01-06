使用文言文回复。用最小必要语言回复，说重点，不要长篇大论。


## 项目概述

MoinUI (墨影UI) 是一个 macOS Swift UI 库，使用 Swift 开发。

开发时：
风格配色：参考shadcn和element plus
功能参考：ant design和element plus

## 开发环境

- **平台**: macOS only
- **语言**: Swift
- **UI 框架**: SwiftUI
- **IDE**: Claude Code
- **项目结构**: Swift Package（使用 Package.swift）

## 常用命令

### 快速启动（推荐）

```bash
# 使用 yarn/npm 脚本启动（推荐）
yarn dev
```

### 构建和运行

```bash
# 使用 Swift Package Manager 构建
swift build
```

### 依赖管理

```bash
# 更新依赖
swift package update

# 解析依赖
swift package resolve

# 查看依赖
swift package show-dependencies
```

### 清理

```bash
# 清理构建产物
swift package clean

# 清理并重新构建
swift package clean && swift build
```

## 编码规范
- 不要运行编译后的代码或程序，你需要使用 swift build编译不要有语法问题或者警告，我已经pnpm dev启动了程序，通过nodemon自动监听你build的的二进制，会自动重启
- 不要写冗余重复的代码，保持代码简洁，尽量封装，复用
- 编写高效代码，极致高性能实现，删除冗余代码、不要的变量、函数、类、接口、属性、方法、模块、包、文件、目录、import
- 注意拆分文件，子组件等，不要使用一个文件的内容太多
- 优化代码时，不要删除我的注释，而是优化注释的文案
- 不需要实现#Preview
- 合理使用context7工具，查询库（antd，element plus，shadcn）的使用文档
- **不要硬编码常量**：所有魔法数字、字符串常量都应定义在 `Sources/MoinUI/Utils/Constants.swift` 中
- 不要允许编译警告，修复所有警告
- 所有组件都以MoinUI开头，如MoinUIButton

## 流程
- **每次编写完后，需使用swift build编译检查是否通过，如果有语法问题，需修复**
- 需要编写完整的测试代码，必须所有测试通过
- 保证极高的测试覆盖率
- 保证在Demo中有对此组件的示例及使用说明，参考AntDesign官网的文档（左侧导航，右侧详细使用说明）
- 善用网络搜索解决问题
- 善用swift-lsp进行代码搜索
- 需求处理完成，回复一个“毕。”在最末尾。

## 文档及国际化
- 文本默认使用中文，代码中也默认使用中文。
- 支持切换到英文（readme，代码国际化、Demo等），可以参考antd的locale类似的配置。
