---
name: notify-bark
description: 通过 Bark App 和本地 macOS 通知向用户发送移动推送通知。每次任务完成时必须使用此功能。标题和内容必须使用**简体中文-文言文**，切勿使用英语。
---

# Notify Bark Skill (Bark 通知技能)

此技能允许你使用 Bark 应用向用户的 iOS 设备发送推送通知，并在 macOS 上同时发送本地桌面通知。

## 前置条件

1. 用户必须在 iOS 设备上安装 **Bark** 应用。
2. 用户必须提供 **Bark Key** (设备密钥)。

## 设置

脚本需要 Bark Key。你可以通过以下方式提供：
1.  设置 `BARK_KEY` 环境变量。
2.  向脚本传递 `--key` 参数。
3.  在 `scripts/` 目录下创建一个 `config.json` 文件，内容为 `{"bark_key": "YOUR_KEY"}`。（推荐）

## 使用方法

使用 `run_command` 工具执行包含在此技能中的 python 脚本。

**⚠️ 重要规则：调用接口时，`--title` 和 `--body` 参数必须严格使用“简体中文-文言文”风格，切勿使用英语或白话文。**

```bash
python3 .agent/skills/notify-bark/scripts/send.py --title "任务已成" --body "按钮组件重构完毕，请君查阅。"
```

### 参数说明

- `--title`: (必填) 通知标题。**必须使用文言文**（如：事项已毕、构建成功）。
- `--body`: (必填) 通知内容。**必须使用文言文**（如：功能开发完备，请君审阅）。
- `--key`: Bark 设备密钥 (如果设置了 `BARK_KEY` 环境变量则可选)。
- `--group`: 通知分组 (例如: "MoinUI")。
- `--level`: 中断级别 (`active`, `timeSensitive`, `passive`)。
- `--icon`: 通知图标的 URL。
- `--url`: 点击通知时打开的 URL。

## 示例：任务完成通知

当你完成了一项重要任务（例如：“重构按钮组件”），运行此命令：

```bash
python3 .agent/skills/notify-bark/scripts/send.py \
  --title "任务已毕" \
  --body "按钮组件重构已毕，请君查阅。" \
  --group "MoinUI"
```

## 故障排除

- 如果通知发送失败，请确保 `BARK_KEY` 正确。
- 检查设备是否连接到互联网。
- 检查命令输出的错误信息。
