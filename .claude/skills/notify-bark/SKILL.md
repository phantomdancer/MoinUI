---
name: notify-bark
description: Send mobile push notifications to the user via the Bark app and local macOS notifications. Use this to notify the user when a long-running task is complete, or when you need their attention.
---

# Notify Bark Skill

This skill allows you to send push notifications to the user's iOS device using the Bark app, and simultaneously sends a local desktop notification if running on macOS.

## Prerequisites

1. The user must have the **Bark** app installed on their iOS device.
2. The user must provide their **Bark Key** (device key).

## Setup

The skill script requires the Bark Key. You can provide it in two ways:
1.  Set the `BARK_KEY` environment variable.
2.  Pass the `--key` argument to the script.
3.  Create a `config.json` file in the `scripts/` directory with `{"bark_key": "YOUR_KEY"}`. (Recommended)

## Usage

Use the `run_command` tool to execute the python script included in this skill.

```bash
python3 .agent/skills/notify-bark/scripts/send.py --title "Task Complete" --body "Message Body"
```

### Arguments

- `--title`: (Required) The title of the notification.
- `--body`: (Required) The content of the notification.
- `--key`: The Bark device key (optional if `BARK_KEY` env var is set).
- `--group`: Group notifications (e.g., "MoinUI").
- `--level`: Interruption level (`active`, `timeSensitive`, `passive`).
- `--icon`: URL for the notification icon.
- `--url`: URL to open when notification is clicked.

## Example: Notify on Task Completion

When you have finished a significant task (e.g., "Refactor Button Component"), run this command:

```bash
python3 .agent/skills/notify-bark/scripts/send.py \
  --title "Task Completed" \
  --body "Button component refactoring is finished. Please review." \
  --group "MoinUI"
```

## Troubleshooting

- If the notification fails, ensure the `BARK_KEY` is correct.
- Check if the device has internet access.
- Check the output of the command for error messages.
