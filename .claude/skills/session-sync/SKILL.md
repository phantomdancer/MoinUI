---
name: session-sync
description: "会话进度同步工具。生成/更新 session-progress 记忆，基于 git log 和项目状态。用于跨设备、跨会话同步工作进度。命令: /session-sync save - 保存进度, /session-sync load - 加载进度, /session-sync status - 查看状态"
---

# Session Sync - 会话进度同步

同步 Claude Code 会话进度到 Serena memory，支持跨设备、跨会话恢复上下文。

## 使用方式

- `/session-sync` 或 `/session-sync save` - 保存当前进度
- `/session-sync load` - 加载并显示进度
- `/session-sync status` - 查看状态

## 工作流程

### 保存进度 (save) / 查看状态 (status)

1. 运行脚本生成进度内容：

```bash
bash .claude/skills/session-sync/scripts/generate-progress.sh
```

2. save 时：将输出写入 `session-progress` 记忆，提示用户提交 `.serena/memories/` 到 git
3. status 时：仅展示输出，不写入记忆

### 加载进度 (load)

1. 调用 `read_memory("session-progress")` 读取记忆
2. 向用户展示当前进度和待办任务
3. 询问用户是否继续之前的任务

## 注意事项

- 记忆存储于 `.serena/memories/` 目录
- 提交此目录到 git 可实现跨设备同步
- 建议每次会话结束时运行 `/session-sync save`
- 新会话开始时运行 `/session-sync load` 恢复上下文
