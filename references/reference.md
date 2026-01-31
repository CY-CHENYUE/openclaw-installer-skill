# OpenClaw 安装部署 - 详细参考

## AI 模型配置

配置文件位置：
- 环境变量：`~/.openclaw/env`
- JSON 配置：`~/.openclaw/openclaw.json`

### Anthropic Claude（推荐）

```bash
# 环境变量
export ANTHROPIC_API_KEY=sk-ant-xxxxx
# 可选：自定义 API 地址（用于代理/中转）
export ANTHROPIC_BASE_URL=https://your-proxy.com

# 设置模型（推荐 claude-sonnet-4-5）
openclaw models set anthropic/claude-sonnet-4-5-20250929
```

可用模型：
- `anthropic/claude-sonnet-4-5-20250929` — 推荐，性价比高
- `anthropic/claude-opus-4-5-20251101` — 最强，最贵
- `anthropic/claude-haiku-4-5-20251001` — 最快，最便宜
- `anthropic/claude-sonnet-4-20250514` — 上一代 Sonnet

使用 Claude Max 订阅：运行 `openclaw onboard` 时选择 setup-token 方式。

### OpenAI GPT

```bash
export OPENAI_API_KEY=sk-xxxxx
# 可选：自定义地址
export OPENAI_BASE_URL=https://your-proxy.com/v1

openclaw models set openai/gpt-4o
```

可用模型：`openai/gpt-4o`、`openai/gpt-4o-mini`、`openai/gpt-4-turbo`、`openai/o1-preview`

> 注意：OpenAI 需支持 v1/responses 接口。

### Google Gemini

```bash
export GOOGLE_API_KEY=AIzaxxxxx

openclaw models set google/gemini-2.0-flash
```

可用模型：`google/gemini-2.0-flash`、`google/gemini-1.5-pro`、`google/gemini-1.5-flash`

### Google Gemini CLI

```bash
export GOOGLE_API_KEY=AIzaxxxxx

openclaw models set gemini-cli/gemini-2.5-pro
```

可用模型：`gemini-cli/gemini-3-pro-preview`、`gemini-cli/gemini-3-flash-preview`、`gemini-cli/gemini-2.5-pro`、`gemini-cli/gemini-2.5-flash`、`gemini-cli/gemini-2.0-flash`

与普通 Gemini 使用相同 API Key，但模型列表不同，包含更新的实验性模型。

### Google Antigravity

```bash
export GOOGLE_API_KEY=AIzaxxxxx

openclaw models set antigravity/gemini-3-pro-high
```

可用模型：`antigravity/gemini-3-pro-high`、`antigravity/gemini-3-pro-low`、`antigravity/gemini-3-flash`、`antigravity/claude-sonnet-4-5`、`antigravity/claude-opus-4-5-thinking`、`antigravity/gpt-oss-120b-medium`

Google 实验性多模型网关，通过单一 API Key 访问多个提供商的模型。

### xAI Grok

```bash
export XAI_API_KEY=xai-xxxxx

openclaw models set xai/grok-4-fast
```

可用模型：`xai/grok-4-fast`、`xai/grok-4`、`xai/grok-3-fast-latest`、`xai/grok-3-mini-fast-latest`、`xai/grok-2-vision-latest`

### OpenRouter（多模型网关）

```bash
export OPENROUTER_API_KEY=sk-or-xxxxx

openclaw models set openrouter/anthropic/claude-sonnet-4-20250514
```

可用模型：`openrouter/anthropic/claude-sonnet-4`、`openrouter/openai/gpt-4o`、`openrouter/google/gemini-pro-1.5`、`openrouter/meta-llama/llama-3-70b-instruct`

OpenRouter 支持几乎所有主流模型，适合需要灵活切换的用户。

### Groq（超快推理）

```bash
export GROQ_API_KEY=gsk_xxxxx

openclaw models set groq/llama-3.3-70b-versatile
```

可用模型：`groq/llama-3.3-70b-versatile`、`groq/llama-3.1-8b-instant`、`groq/mixtral-8x7b-32768`、`groq/gemma2-9b-it`

### Mistral AI

```bash
export MISTRAL_API_KEY=xxxxx

openclaw models set mistral/mistral-large-latest
```

可用模型：`mistral/mistral-large-latest`、`mistral/mistral-small-latest`、`mistral/codestral-latest`

### Azure OpenAI

```bash
export AZURE_OPENAI_API_KEY=xxxxx
export AZURE_OPENAI_ENDPOINT=https://your-resource.openai.azure.com
export AZURE_OPENAI_API_VERSION=2024-02-15-preview

openclaw models set azure/gpt-4o
```

需要在 Azure Portal 中创建 OpenAI 资源并部署模型。

### OpenCode（免费层）

```bash
export OPENCODE_API_KEY=xxxxx

openclaw models set opencode/claude-sonnet-4-5
```

可用模型：`opencode/claude-sonnet-4-5`、`opencode/claude-opus-4-5`、`opencode/gpt-5`、`opencode/gemini-3-pro`、`opencode/glm-4.7-free`、`opencode/gpt-5-codex`

OpenCode 提供免费额度，适合试用。

### DeepSeek（国内）

```bash
export DEEPSEEK_API_KEY=sk-xxxxx
export DEEPSEEK_BASE_URL=https://api.deepseek.com

openclaw models set deepseek/deepseek-chat
```

可用模型：`deepseek/deepseek-chat`、`deepseek/deepseek-reasoner`、`deepseek/deepseek-coder`

### Kimi / 月之暗面（国内）

```bash
export MOONSHOT_API_KEY=sk-xxxxx

openclaw models set kimi/moonshot-v1-128k
```

可用模型：`kimi/moonshot-v1-auto`、`kimi/moonshot-v1-8k`、`kimi/moonshot-v1-32k`、`kimi/moonshot-v1-128k`

### 智谱 GLM（国内）

```bash
export ZAI_API_KEY=xxxxx

openclaw models set zai/glm-4.7
```

可用模型：`zai/glm-4.7`、`zai/glm-4.6`、`zai/glm-4.6v`、`zai/glm-4.5-flash`、`zai/glm-4.5-air`

> 也可通过 JSON 自定义 Provider 方式配置（baseUrl: `https://open.bigmodel.cn/api/paas/v4`）。

### MiniMax（国内）

```bash
export MINIMAX_API_KEY=xxxxx

openclaw models set minimax/MiniMax-M2.1
```

可用模型：`minimax/MiniMax-M2.1`、`minimax/MiniMax-M2`

> 也可通过 JSON 自定义 Provider 方式配置（baseUrl: `https://api.minimax.chat/v1`）。

### Ollama（本地部署）

```bash
# 先安装 Ollama
curl -fsSL https://ollama.com/install.sh | sh

# 拉取模型
ollama pull llama3

# 配置 OpenClaw
openclaw models set ollama/llama3
```

可用模型：`ollama/llama3`、`ollama/llama3:70b`、`ollama/mistral`、`ollama/codellama`（或任意已拉取模型）

无需 API Key，模型运行在本地。默认连接 `http://localhost:11434`。

### 自定义 Provider / API 代理

适用于 OneAPI、NewAPI 等中转服务：

```json
{
  "models": {
    "providers": {
      "custom": {
        "apiKey": "your-key",
        "baseUrl": "https://your-oneapi.com/v1",
        "models": ["gpt-4o", "claude-sonnet-4-20250514"]
      }
    }
  }
}
```

---

## 消息通道配置

### Telegram

1. 打开 Telegram，搜索 `@BotFather`
2. 发送 `/newbot`，按提示创建 Bot
3. 获取 Bot Token（格式：`123456789:ABCdefGhIJKlmNoPQRsTUVwxyz`）
4. 获取你的 User ID：搜索 `@userinfobot`，发送任意消息
5. 配置：
```bash
openclaw channels add --channel telegram --token "你的BOT_TOKEN"
```
6. 测试：向你的 Bot 发送消息

### Discord

1. 访问 https://discord.com/developers/applications
2. 点击 "New Application"，创建应用
3. 进入 Bot 页面，点击 "Reset Token" 获取 Token
4. 开启以下权限：
   - Privileged Gateway Intents → Message Content Intent ✓
   - Bot Permissions → Send Messages, Read Message History
5. 生成邀请链接，将 Bot 添加到你的服务器
6. 获取频道 ID：Discord 设置 → 高级 → 开发者模式 → 右键频道 → 复制 ID
7. 配置：
```bash
openclaw channels add --channel discord --token "你的BOT_TOKEN"
```

### WhatsApp

```bash
openclaw gateway start
# 启动后查看日志中的二维码
openclaw logs --follow
# 用手机 WhatsApp 扫码
```

### Slack

1. 访问 https://api.slack.com/apps → Create New App
2. 选择 "From scratch"
3. Features → OAuth & Permissions → 添加 Scopes：
   - `chat:write`, `channels:history`, `channels:read`, `app_mentions:read`
4. Install App → 获取 Bot User OAuth Token
5. Features → App-Level Tokens → 创建 Token（scope: `connections:write`）
6. 配置：
```bash
openclaw channels add --channel slack --bot-token "xoxb-xxxxx" --app-token "xapp-xxxxx"
```

### 微信

微信接入需要第三方插件支持：

```bash
openclaw plugins install @openclaw/wechat
```

> 注意：微信接入稳定性取决于第三方服务，可能需要定期重新登录。

### 飞书

飞书使用 WebSocket 长连接，无需公网服务器：

1. 访问 https://open.feishu.cn/app → 创建企业自建应用
2. 获取 App ID 和 App Secret
3. 权限管理 → 添加：`im:message`、`im:message.receive_v1`
4. 事件订阅 → 请求地址：使用 WebSocket 模式
5. 安装插件并配置：
```bash
openclaw plugins install @openclaw/feishu
openclaw channels add --channel feishu
# 按提示输入 App ID 和 App Secret
```
6. 在飞书管理后台发布应用

> 飞书支持 `feishu`（feishu.cn 国内）和 `lark`（lark.com 海外）两个域。

### iMessage（仅 macOS）

1. 系统设置 → 隐私与安全性 → 完全磁盘访问权限 → 添加终端
2. 配置：
```bash
openclaw channels add --channel imessage
```

---

## Docker 部署

### docker-compose 方式

创建 `docker-compose.yml`：
```yaml
version: '3.8'
services:
  openclaw:
    image: openclaw/openclaw:latest
    container_name: openclaw
    ports:
      - "18789:18789"
    volumes:
      - ~/.openclaw:/root/.openclaw
    env_file:
      - ~/.openclaw/env
    restart: unless-stopped
```

启动：
```bash
docker-compose up -d
docker-compose logs -f
```

### 单容器方式

```bash
docker run -d \
  --name openclaw \
  -p 18789:18789 \
  -v ~/.openclaw:/root/.openclaw \
  --env-file ~/.openclaw/env \
  --restart unless-stopped \
  openclaw/openclaw:latest
```

---

## 源码安装

```bash
git clone https://github.com/openclaw/openclaw.git
cd openclaw
pnpm install
pnpm ui:build
pnpm build
pnpm openclaw onboard --install-daemon
pnpm gateway:watch  # 开发模式
```

---

## 故障排查

### Node.js 版本过低

```bash
# macOS
brew install node@22

# Ubuntu/Debian
curl -fsSL https://deb.nodesource.com/setup_22.x | sudo -E bash -
sudo apt-get install -y nodejs

# CentOS/RHEL
curl -fsSL https://rpm.nodesource.com/setup_22.x | sudo bash -
sudo yum install -y nodejs

# Arch Linux
sudo pacman -S nodejs npm
```

### API 连接失败

```bash
# 诊断
openclaw doctor

# 手动测试 API（以 Anthropic 为例）
curl -s https://api.anthropic.com/v1/messages \
  -H "x-api-key: $ANTHROPIC_API_KEY" \
  -H "anthropic-version: 2023-06-01" \
  -H "content-type: application/json" \
  -d '{"model":"claude-sonnet-4-20250514","max_tokens":10,"messages":[{"role":"user","content":"hi"}]}'
```

常见原因：
- API Key 错误或过期 → 重新获取
- 网络问题 → 检查是否需要代理
- 模型名称错误 → 检查拼写

### Gateway 无法启动

```bash
# 查看日志
openclaw logs --follow

# 检查端口占用
lsof -i :18789

# 强制停止后重启
openclaw gateway stop
openclaw gateway start
```

### Telegram 无响应

1. 确认 Bot Token 正确：`curl https://api.telegram.org/bot<TOKEN>/getMe`
2. 确认 User ID 在白名单中
3. 确认 Gateway 正在运行：`openclaw gateway status`
4. 查看日志中的 Telegram 相关错误

### macOS sharp 编译失败

Node.js v22.22.0+ 在 macOS 上可能遇到 sharp 依赖编译问题：

```bash
# 方案 1：使用略低版本
nvm install 22.21.0
nvm use 22.21.0

# 方案 2：手动安装 sharp
npm install -g sharp
```

### 日志清理

```bash
# 清理 Gateway 临时日志
rm -f /tmp/openclaw-gateway.log

# 清理配置目录下的日志
rm -f ~/.openclaw/logs/*.log

# 查看日志占用空间
du -sh ~/.openclaw/logs/ /tmp/openclaw-gateway.log 2>/dev/null
```

### 备份与恢复

```bash
# 备份
cp -r ~/.openclaw ~/openclaw-backup-$(date +%Y%m%d)

# 恢复
cp -r ~/openclaw-backup-YYYYMMDD ~/.openclaw
```

### 完全卸载

```bash
openclaw gateway stop
npm uninstall -g openclaw
rm -rf ~/.openclaw  # 删除所有配置和数据
```

---

## 安全配置建议

### 沙箱模式

```json
{
  "agents": {
    "defaults": {
      "sandbox": {
        "mode": "non-main"
      }
    }
  }
}
```

### 用户白名单

```json
{
  "security": {
    "dm": {
      "mode": "pairing",
      "allowedUsers": ["+86138xxxx", "telegram:12345"]
    }
  }
}
```

### 禁用危险功能

```json
{
  "agents": {
    "defaults": {
      "tools": {
        "deny": ["shell", "filesystem.write"]
      }
    }
  }
}
```

---

## 相关资源

- 官方文档：https://docs.openclaw.ai
- GitHub 仓库：https://github.com/openclaw/openclaw
- 中文配置指南：https://github.com/xianyu110/clawbot
- ClawdBotInstaller：https://github.com/miaoxworld/ClawdBotInstaller
- 菜鸟教程：https://www.runoob.com/ai-agent/moltbot-clawdbot-tutorial.html
