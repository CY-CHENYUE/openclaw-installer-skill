#!/bin/bash
#
# OpenClaw 健康检查脚本
# 检查安装状态、配置完整性和服务运行状况
#

# 颜色
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'
BOLD='\033[1m'

PASS=0
WARN=0
FAIL=0

check_pass() {
    echo -e "  ${GREEN}✓${NC} $1"
    ((PASS++))
}

check_warn() {
    echo -e "  ${YELLOW}!${NC} $1"
    ((WARN++))
}

check_fail() {
    echo -e "  ${RED}✗${NC} $1"
    ((FAIL++))
}

echo ""
echo -e "${CYAN}${BOLD}OpenClaw 健康检查${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""

# 1. Node.js 检查
echo -e "${BOLD}[1] Node.js 环境${NC}"
if command -v node &> /dev/null; then
    NODE_VER=$(node -v | sed 's/v//' | cut -d. -f1)
    if [ "$NODE_VER" -ge 22 ]; then
        check_pass "Node.js $(node -v)"
    else
        check_fail "Node.js $(node -v) — 需要 v22+"
    fi
else
    check_fail "未安装 Node.js"
fi
echo ""

# 2. OpenClaw CLI 检查
echo -e "${BOLD}[2] OpenClaw CLI${NC}"
if command -v openclaw &> /dev/null; then
    OC_VER=$(openclaw --version 2>/dev/null || echo "未知")
    check_pass "openclaw ${OC_VER}"
elif command -v moltbot &> /dev/null; then
    check_warn "检测到 moltbot（旧名称），建议升级: npm install -g openclaw@latest"
elif command -v clawdbot &> /dev/null; then
    check_warn "检测到 clawdbot（旧名称），建议升级: npm install -g openclaw@latest"
else
    check_fail "未安装 OpenClaw CLI — 运行: npm install -g openclaw@latest"
fi
echo ""

# 3. 配置文件检查
echo -e "${BOLD}[3] 配置文件${NC}"
CONFIG_DIR="$HOME/.openclaw"

if [ -d "$CONFIG_DIR" ]; then
    check_pass "配置目录存在: $CONFIG_DIR"
else
    check_fail "配置目录不存在: $CONFIG_DIR"
fi

if [ -f "$CONFIG_DIR/env" ]; then
    # 检查文件权限
    PERMS=$(stat -c "%a" "$CONFIG_DIR/env" 2>/dev/null || stat -f "%Lp" "$CONFIG_DIR/env" 2>/dev/null)
    if [ "$PERMS" = "600" ]; then
        check_pass "环境变量文件权限正确 (600)"
    else
        check_warn "环境变量文件权限为 $PERMS，建议设为 600: chmod 600 $CONFIG_DIR/env"
    fi

    # 检查是否有 API Key 配置
    if grep -q "API_KEY" "$CONFIG_DIR/env" 2>/dev/null; then
        check_pass "检测到 API Key 配置"
    else
        check_warn "未检测到 API Key — 请配置 AI 模型"
    fi
else
    check_warn "环境变量文件不存在: $CONFIG_DIR/env"
fi

if [ -f "$CONFIG_DIR/openclaw.json" ]; then
    check_pass "JSON 配置文件存在"
    # 检查模型配置
    if command -v python3 &> /dev/null; then
        MODEL=$(python3 -c "import json; d=json.load(open('$CONFIG_DIR/openclaw.json')); print(d.get('agents',{}).get('defaults',{}).get('model',{}).get('primary','未配置'))" 2>/dev/null)
        if [ -n "$MODEL" ] && [ "$MODEL" != "未配置" ]; then
            check_pass "默认模型: $MODEL"
        else
            check_warn "未配置默认模型"
        fi
    fi
else
    check_warn "JSON 配置文件不存在"
fi
echo ""

# 4. Gateway 服务检查
echo -e "${BOLD}[4] Gateway 服务${NC}"
if pgrep -f "openclaw.*gateway\|moltbot.*gateway\|clawdbot.*gateway" > /dev/null 2>&1; then
    check_pass "Gateway 进程正在运行"
else
    check_warn "Gateway 未运行 — 启动: openclaw gateway start"
fi

# 检查端口
if command -v lsof &> /dev/null; then
    if lsof -i :18789 > /dev/null 2>&1; then
        check_pass "端口 18789 已监听"
    else
        check_warn "端口 18789 未监听"
    fi
elif command -v ss &> /dev/null; then
    if ss -tlnp | grep -q ":18789" 2>/dev/null; then
        check_pass "端口 18789 已监听"
    else
        check_warn "端口 18789 未监听"
    fi
fi
echo ""

# 5. 网络检查
echo -e "${BOLD}[5] 网络连接${NC}"
if curl -s --max-time 5 https://api.anthropic.com > /dev/null 2>&1; then
    check_pass "Anthropic API 可达"
else
    check_warn "Anthropic API 不可达 — 可能需要代理"
fi

if curl -s --max-time 5 https://api.openai.com > /dev/null 2>&1; then
    check_pass "OpenAI API 可达"
else
    check_warn "OpenAI API 不可达"
fi
echo ""

# 汇总
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "${BOLD}检查结果:${NC} ${GREEN}通过 $PASS${NC}  ${YELLOW}警告 $WARN${NC}  ${RED}失败 $FAIL${NC}"

if [ $FAIL -eq 0 ] && [ $WARN -eq 0 ]; then
    echo -e "${GREEN}一切正常!${NC}"
elif [ $FAIL -eq 0 ]; then
    echo -e "${YELLOW}基本正常，有一些可选项待配置${NC}"
else
    echo -e "${RED}存在问题需要修复${NC}"
fi
echo ""
