# 会话进度

## 近期提交 (git log)
- c6faf6f feat(会话同步): 添加会话进度同步功能和相关文档
- d0993d8 docs: 更新工作流程文档，添加进度恢复和结束步骤
- 1d9b9bb feat(按钮/标签): 新增阴影效果和焦点状态功能
- 94942d5 feat(tag): 添加 Tag 组件专属 Token 并完善国际化
- eeae570 docs: 更新组件文档和状态记录
- 8a80b0e refactor(tag): 将 processing 颜色枚举重命名为 primary 并更新相关使用
- bbf7a41 feat(标签): 添加标签尺寸和圆角属性支持
- d5429f9 feat(CheckableTag): 添加按压状态并优化交互样式
- 17723d3 feat(components): 添加 Tag 组件及其相关功能
- 11898e4 update

## 变更统计 (最近5次提交)
```
 Sources/Demo/Examples/Tag/TagTokenSection.swift    |  81 ++++++-
 Sources/Demo/Locales/Button/en-US.json             |   7 +
 Sources/Demo/Locales/Button/zh-CN.json             |   7 +
 Sources/Demo/Locales/Tag/en-US.json                |  30 ++-
 Sources/Demo/Locales/Tag/zh-CN.json                |  30 ++-
 Sources/MoinUI/Components/Button/Button.swift      |  53 ++++-
 Sources/MoinUI/Components/Tag/Tag.swift            |  49 +++--
 Sources/MoinUI/Config/ConfigProvider.swift         | 128 ++++++++++-
 package.json                                       |   3 +-
 44 files changed, 2309 insertions(+), 279 deletions(-)
```

## 最近命令历史
<command>
最近命令历史 用xml标签把每一条分开
</command>
<command>
/ide 
</command>
<command>
流程需要更新了，应该是使用skill来操作进度，而不是serena
</command>
<command>
流程不是全部去掉啊，serena本身的记忆功能还是需要的，因为我有roadmap等还需要操作呢。只是把session-sync整合加进去
</command>
<command>
现在该做什么了
</command>
