# OpenClaw 配置示例

## 最小化配置

### 使用 Anthropic Claude

`~/.openclaw/env`：
```bash
export ANTHROPIC_API_KEY=sk-ant-api03-xxxxx
```

`~/.openclaw/openclaw.json`：
```json
{
  "agent": {
    "model": "anthropic/claude-sonnet-4-5-20250929"
  }
}
```

### 使用 OpenAI

`~/.openclaw/env`：
```bash
export OPENAI_API_KEY=sk-xxxxx
```

`~/.openclaw/openclaw.json`：
```json
{
  "agent": {
    "model": "openai/gpt-4o"
  }
}
```

---

## 国内模型配置

### DeepSeek

`~/.openclaw/env`：
```bash
export DEEPSEEK_API_KEY=sk-xxxxx
export DEEPSEEK_BASE_URL=https://api.deepseek.com
```

`~/.openclaw/openclaw.json`：
```json
{
  "agent": {
    "model": "deepseek/deepseek-chat"
  }
}
```

### Kimi（月之暗面）

`~/.openclaw/env`：
```bash
export MOONSHOT_API_KEY=sk-xxxxx
```

`~/.openclaw/openclaw.json`：
```json
{
  "agent": {
    "model": "kimi/moonshot-v1-128k"
  }
}
```

### 通过 API 代理使用（OneAPI/NewAPI）

`~/.openclaw/env`：
```bash
export ANTHROPIC_API_KEY=sk-xxxxx
export ANTHROPIC_BASE_URL=https://your-oneapi.com
```

`~/.openclaw/openclaw.json`：
```json
{
  "agent": {
    "model": "anthropic/claude-sonnet-4-5-20250929"
  },
  "models": {
    "providers": {
      "anthropic": {
        "baseUrl": "https://your-oneapi.com"
      }
    }
  }
}
```

---

## 完整配置示例

包含 AI 模型 + Telegram + 安全配置：

`~/.openclaw/env`：
```bash
export ANTHROPIC_API_KEY=sk-ant-api03-xxxxx
export TELEGRAM_BOT_TOKEN=123456789:ABCdefGhIJKlmNoPQRsTUVwxyz
```

`~/.openclaw/openclaw.json`：
```json
{
  "agent": {
    "model": "anthropic/claude-sonnet-4-5-20250929",
    "name": "小助手",
    "owner": "主人"
  },
  "gateway": {
    "port": 18789
  },
  "channels": {
    "telegram": {
      "token": "123456789:ABCdefGhIJKlmNoPQRsTUVwxyz",
      "allowedUsers": ["987654321"]
    }
  },
  "security": {
    "dm": {
      "mode": "pairing"
    }
  },
  "agents": {
    "defaults": {
      "sandbox": {
        "mode": "non-main"
      },
      "workspace": "~/openclaw-workspace"
    }
  },
  "timezone": "Asia/Shanghai"
}
```

---

## Telegram + Discord 双通道

`~/.openclaw/openclaw.json`：
```json
{
  "agent": {
    "model": "anthropic/claude-sonnet-4-5-20250929"
  },
  "channels": {
    "telegram": {
      "token": "TELEGRAM_BOT_TOKEN",
      "allowedUsers": ["USER_ID"]
    },
    "discord": {
      "token": "DISCORD_BOT_TOKEN",
      "channelId": "CHANNEL_ID"
    }
  }
}
```

---

## 飞书配置示例

`~/.openclaw/openclaw.json`：
```json
{
  "agent": {
    "model": "anthropic/claude-sonnet-4-5-20250929"
  },
  "channels": {
    "feishu": {
      "appId": "cli_xxxxx",
      "appSecret": "xxxxx",
      "connectionMode": "websocket",
      "domain": "feishu",
      "requireMention": true
    }
  }
}
```

> `domain` 设为 `feishu`（国内 feishu.cn）或 `lark`（海外 lark.com）。

---

## Docker Compose 完整示例

`docker-compose.yml`：
```yaml
version: '3.8'
services:
  openclaw:
    image: openclaw/openclaw:latest
    container_name: openclaw
    ports:
      - "18789:18789"
    volumes:
      - ./config:/root/.clawdbot
      - ./workspace:/root/openclaw-workspace
    env_file:
      - ./config/env
    restart: unless-stopped
    environment:
      - TZ=Asia/Shanghai
```

---

## systemd 服务配置

`/etc/systemd/system/openclaw.service`：
```ini
[Unit]
Description=OpenClaw AI Assistant Gateway
After=network.target

[Service]
Type=simple
User=你的用户名
ExecStart=/usr/bin/openclaw gateway --port 18789
Restart=on-failure
RestartSec=10
Environment=HOME=/home/你的用户名
EnvironmentFile=/home/你的用户名/.clawdbot/env

[Install]
WantedBy=multi-user.target
```

启用：
```bash
sudo systemctl daemon-reload
sudo systemctl enable openclaw
sudo systemctl start openclaw
sudo systemctl status openclaw
```
