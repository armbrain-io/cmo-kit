# cmo-kit

AI shortcuts for fractional CMOs. One command to install, zero config.

## Install

**Mac / Linux:**
```bash
bash <(curl -sL https://raw.githubusercontent.com/benfinklea/cmo-kit/main/install.sh)
```

**Windows (PowerShell):**
```powershell
irm https://raw.githubusercontent.com/benfinklea/cmo-kit/main/install.ps1 | iex
```

## What You Get

### AI Essentials

| Shortcut | What it does |
|----------|-------------|
| `c` | Launch Claude Code |
| `g` | Launch Gemini CLI |
| `ai how do I price a retainer` | Quick question to Claude (no session) |
| `gi summarize this quarter` | Quick question to Gemini (no session) |
| `weather` | Weather in your terminal |
| `forecast` | Full 3-day forecast |

### Coppermind CMO

Client memory for fractional CMOs. Switch between clients in seconds. Never lose context between meetings.

| Shortcut | What it does |
|----------|-------------|
| `cmo` | Show all Coppermind commands |
| `cmo-clients` | Switch between clients instantly |
| `cmo-prep` | Meeting prep with full client context |
| `cmo-brief` | Daily briefing across all your clients |

Not in the beta yet? Type `cmo` and it'll tell you how to get in.

## Prerequisites

- [Claude Code](https://docs.anthropic.com/en/docs/claude-code) — `npm install -g @anthropic-ai/claude-code`
- [Gemini CLI](https://github.com/google-gemini/gemini-cli) — `npm install -g @anthropic-ai/gemini-cli` (optional)

## Uninstall

Open your shell config (`~/.zshrc`, `~/.bashrc`, or `$PROFILE` on Windows) and delete the block between `# ── cmo-kit` and `# ── end cmo-kit`.

## About Coppermind CMO

AI memory layer for fractional CMOs managing multiple clients. Your AI remembers every meeting, every decision, every campaign — organized by client. When an engagement ends, hand off a complete AI brain as a deliverable.

**Request beta access:** ben@volacci.com
