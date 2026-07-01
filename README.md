# project001-QuantDinger 中文版

## 目标

仿照 GitHub 上 `brokermr810/QuantDinger` 的完整项目结构，制作一个默认中文体验的本地版本。

## 源码来源

- 主仓库：`source/QuantDinger`
- Web 前端源码：`source/QuantDinger-Vue`

主仓库负责后端、Docker Compose、MCP 和文档；Web UI 源码来自兄弟仓库 `QuantDinger-Vue`。

## 中文化策略

- 保留原项目 UI、路由、功能和多语言能力。
- 将 Web 前端默认语言从 `en-US` 改为 `zh-CN`。
- 首屏加载文案、HTML 标题、无 JavaScript 提示改为中文。
- 请求头和 AI 相关接口的默认语言改为 `zh-CN`。
- 语言菜单中将简体中文放在第一项。

## 本地运行

前端源码目录：

```powershell
Set-Location C:\Users\22212\Documents\QuantDinge\project001-QuantDinger中文版\source\QuantDinger-Vue
pnpm install
pnpm run dev
```

默认前端开发地址为 `http://localhost:8000`。如果后端也需要本地运行，主仓库已通过 `.env` 指向这个中文版前端源码，可在 `source/QuantDinger` 中使用：

```powershell
docker compose -f docker-compose.yml -f docker-compose.build.yml up --build
```

