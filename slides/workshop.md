---
title: Vibe Coding Workshop
subtitle: 编译示例
author: Tech GC
aspectratio: 169
theme: Copenhagen
mainfont: Helvetica Neue
sansfont: Helvetica Neue
monofont: Menlo
CJKmainfont: PingFang SC
header-includes: |
  \setbeamertemplate{navigation symbols}{}
---

## Workshop 内容草稿

- 目标：明确这次活动要完成的小项目
- 演示：描述需求、生成代码、运行并检查
- 实践：参与者完成一个修改并验证结果

## 示例练习

请为一个待办事项页面编写需求：

1. 可以添加任务
2. 可以标记任务完成
3. 刷新页面后保留任务

## 代码显示示例

```python
def greet(name):
    return f"Hello, {name}!"

print(greet("Workshop"))
```
