---
name: openclaw-installer
description: OpenClaw（原 Clawdbot/Moltbot）私人 AI 助手的安装部署与配置技能。当用户说"安装 OpenClaw"、"部署 Clawdbot"、"安装 Moltbot"、"一键安装 AI 助手"、"配置 OpenClaw"、"install openclaw"时使用。支持多平台安装、多模型配置（含国内模型）、多消息通道接入。
---

# OpenClaw 安装部署技能

帮助用户安装、配置和管理 OpenClaw（原 Clawdbot/Moltbot）私人 AI 助手。

- 官方仓库：https://github.com/openclaw/openclaw
- 官方文档：https://docs.openclaw.ai
- 系统要求：Node.js ≥ 22，macOS 12+ / Ubuntu 20.04+ / Debian 11+ / CentOS 8+，内存 ≥ 2GB

## 执行流程

### Step 1: 环境检测

```bash
uname -a
node -v 2>/dev/null
which npm pnpm 2>/dev/null
```

- 无 Node.js 或版本 < 22 → Step 2a
- Node.js ≥ 22 → Step 2b

### Step 2a: 安装 Node.js（如需要）

| 系统 | 命令 |
|------|------|
| macOS | `brew install node@22`（无 Homebrew 先装：`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`）|
| Ubuntu/Debian | `curl -fsSL https://deb.nodesource.com/setup_22.x \| sudo -E bash - && sudo apt-get install -y nodejs` |
| CentOS/RHEL | `curl -fsSL https://rpm.nodesource.com/setup_22.x \| sudo bash - && sudo yum install -y nodejs` |
| Arch Linux | `sudo pacman -S nodejs npm` |
| 通用 (nvm) | `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.0/install.sh \| bash && nvm install 22` |

### Step 2b: 安装 OpenClaw

```bash
npm install -g openclaw@latest
openclaw --version
openclaw config set gateway.mode local
```

> 如果 npm 全局安装遇到权限问题，加 `sudo`：`sudo npm install -g openclaw@latest`
> 配置目录自动创建于 `~/.openclaw/`（旧版 `~/.clawdbot` 会自动迁移）。
> 其他安装方式见 references/reference.md（Docker 部署、源码安装）。

### Step 3: 配置 AI 模型

向用户确认模型选择，然后按 references/reference.md 中对应章节配置。

**海外**: Anthropic Claude (推荐) / OpenAI / Gemini / Gemini CLI / Antigravity / Grok / OpenRouter / Groq / Mistral / Azure OpenAI / OpenCode
**国内**: DeepSeek / Kimi / 智谱 GLM / MiniMax
**本地**: Ollama (无需 API Key)

基本配置方式：

```bash
# 1. 写入环境变量（替换 xxxxx 为用户的实际 Key）
echo 'export ANTHROPIC_API_KEY=sk-ant-xxxxx' >> ~/.openclaw/env
chmod 600 ~/.openclaw/env
# 2. 当前 shell 也加载（用于后续测试）
source ~/.openclaw/env
# 3. 设置默认模型
openclaw models set anthropic/claude-sonnet-4-5-20250929
```

> 各模型详细配置：在 references/reference.md 中搜索模型名称（如 "DeepSeek"、"Ollama"）。
> 配置文件示例：见 references/examples.md。

### Step 4: 身份与基础配置

```bash
openclaw agents set-identity --agent main --name "小助手"
openclaw setup --workspace ~/openclaw-workspace
```

### Step 5: 配置消息通道

| 平台 | 难度 | 核心步骤 |
|------|------|---------|
| Telegram | 低 | @BotFather 创建 Bot → Token + User ID |
| Discord | 中 | 创建 App → Bot Token + Channel ID |
| WhatsApp | 低 | 扫码登录 |
| Slack | 中 | 创建 Slack App → Bot Token + App Token |
| 微信 | 中 | 第三方插件 |
| 飞书 | 中 | WebSocket 长连接，无需公网 |
| iMessage | 低 | 仅 macOS |

> 各通道详细步骤：在 references/reference.md 中搜索平台名称（如 "Telegram"、"飞书"）。

### Step 6: 测试连接

```bash
openclaw agent --local --message "你好，请自我介绍"
openclaw doctor
bash scripts/health-check.sh
```

> 故障排查：在 references/reference.md 中搜索 "故障排查"。

### Step 7: 启动服务

```bash
# 前台调试（首次建议用前台确认无报错）
openclaw gateway --port 18789 --verbose
# 确认正常后 Ctrl+C 停止，改为后台运行
openclaw gateway start
# Web UI: http://localhost:18789
```

开机自启（用户确认需要后执行，此命令为交互式）：

```bash
openclaw onboard --install-daemon
```

## 常用命令

| 操作 | 命令 |
|------|------|
| 启停 | `openclaw gateway start/stop/restart/status` |
| 日志 | `openclaw logs --follow` |
| 诊断 | `openclaw doctor` |
| 健康检查 | `openclaw health` |
| 切换模型 | `openclaw models set <model>` |
| 配置向导 | `openclaw configure` |
| 通道管理 | `openclaw channels add/list/remove` |
| 发消息 | `openclaw message send --target <目标> --message "内容"` |
| Agent | `openclaw agent --message "任务"` |
| 身份 | `openclaw agents set-identity --agent main --name "名字"` |
| 记忆管理 | `openclaw memory` |
| 插件 | `openclaw plugins` |
| 安全审计 | `openclaw security audit` |
| 清日志 | `rm -f /tmp/openclaw-gateway.log ~/.openclaw/logs/*.log` |

## 安全提醒

安装前必须告知用户：
1. OpenClaw 拥有**完整计算机访问权限**
2. 推荐在专用服务器或虚拟机部署
3. 建议启用沙箱模式、限制用户白名单
4. API Key 文件权限设为 600：`chmod 600 ~/.openclaw/env`

## 参考文件

- references/reference.md — AI 模型配置、消息通道、Docker、故障排查、安全配置
- references/examples.md — 配置文件完整示例
- scripts/health-check.sh — 健康检查脚本

---

作者: CY-CHENYUE
