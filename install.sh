#!/usr/bin/env bash
# ============================================================
#  cmo-kit — AI Shortcuts for CMOs
#  https://github.com/benfinklea/cmo-kit
#
#  Install:
#    bash <(curl -sL https://raw.githubusercontent.com/benfinklea/cmo-kit/main/install.sh)
#
#  What it adds:
#    c            → Claude Code (full session)
#    g            → Gemini CLI (full session)
#    ai <prompt>  → Quick question to Claude
#    gi <prompt>  → Quick question to Gemini
#    weather      → Weather in your terminal
#    cmo          → Coppermind CMO commands
#    cmo-clients  → Switch between clients
#    cmo-prep     → Meeting prep for active client
#    cmo-brief    → Daily client briefing
#
#  Uninstall:
#    Remove the "cmo-kit" block from your shell config
# ============================================================

set -e

MARKER="# ── cmo-kit"

# --- Detect OS ---
case "$(uname -s)" in
  Darwin*) OS="mac" ;;
  Linux*)  OS="linux" ;;
  MINGW*|MSYS*|CYGWIN*) OS="windows-bash" ;;
  *) OS="unknown" ;;
esac

# --- Detect shell config ---
if [ -f "$HOME/.zshrc" ]; then
  SHELL_RC="$HOME/.zshrc"
elif [ -f "$HOME/.bashrc" ]; then
  SHELL_RC="$HOME/.bashrc"
elif [ -f "$HOME/.bash_profile" ]; then
  SHELL_RC="$HOME/.bash_profile"
else
  SHELL_RC="$HOME/.bashrc"
  touch "$SHELL_RC"
fi

# --- Check if already installed ---
if grep -q "$MARKER" "$SHELL_RC" 2>/dev/null; then
  echo "cmo-kit is already installed in $SHELL_RC"
  echo "To reinstall, first remove the 'cmo-kit' block from that file."
  exit 0
fi

# --- Optional city for weather ---
echo ""
echo "  cmo-kit — AI Shortcuts for CMOs"
echo "  ────────────────────────────────"
echo ""
read -rp "  City for weather shortcut (e.g. Austin, London) [skip]: " CITY
CITY_SLUG=$(echo "$CITY" | tr ' ' '_')

echo ""
echo "  Installing to $SHELL_RC ..."

# --- Write shortcuts ---
cat >> "$SHELL_RC" << 'BLOCK'

# ── cmo-kit — AI Shortcuts for CMOs ──────────────────
# https://github.com/benfinklea/cmo-kit

# ─── AI essentials ───

# Claude Code (full session)
c() { claude "$@"; }

# Gemini CLI (full session)
alias g='gemini'

# Quick question to Claude (prints answer, exits)
ai() { claude -p "$*"; }

# Quick question to Gemini (prints answer, exits)
gi() { gemini -p "$*"; }

# ─── Coppermind CMO ───

_coppermind_check() {
  if pip show coppermind-cmo &>/dev/null 2>&1; then
    return 0
  fi
  echo ""
  echo "  ┌─────────────────────────────────────────────────────┐"
  echo "  │  Coppermind CMO — AI memory for fractional CMOs     │"
  echo "  │                                                     │"
  echo "  │  Switch clients in seconds. Never lose context.     │"
  echo "  │  Hand off a complete AI brain when engagements end.  │"
  echo "  │                                                     │"
  echo "  │  Request beta access → ben@volacci.com              │"
  echo "  └─────────────────────────────────────────────────────┘"
  echo ""
  return 1
}

# Show all Coppermind commands
cmo() {
  if ! _coppermind_check; then return; fi
  echo ""
  echo "  Coppermind CMO"
  echo "  ──────────────"
  echo "  cmo-clients   Switch between clients"
  echo "  cmo-prep      Meeting prep for active client"
  echo "  cmo-brief     Daily client briefing"
  echo ""
  echo "  Inside Claude you also get:"
  echo "  /cmo-morning  /cmo-handoff  /cmo-review  /cmo-followup"
  echo ""
}

# Client switcher
cmo-clients() {
  if ! _coppermind_check; then return; fi
  claude "Show my client list using list_minds. Display as a numbered list with each client's name and last activity. Then ask which one I want to switch to."
}

# Meeting prep
cmo-prep() {
  if ! _coppermind_check; then return; fi
  claude "Run meeting prep for my active client. Check my calendar for the next meeting, pull relevant memories, and build a briefing with key context, open items, and talking points."
}

# Daily briefing
cmo-brief() {
  if ! _coppermind_check; then return; fi
  claude "Give me my daily CMO briefing. For each active client: last meeting takeaways, open action items, upcoming meetings, and anything that needs attention today."
}

BLOCK

# Add weather if city provided
if [ -n "$CITY_SLUG" ]; then
  cat >> "$SHELL_RC" << EOF

# Weather
alias weather='curl -s "wttr.in/${CITY_SLUG}?format=3"'
alias forecast='curl -s "wttr.in/${CITY_SLUG}"'
EOF
fi

# Close the block
echo "" >> "$SHELL_RC"
echo "# ── end cmo-kit ────────────────────────────────────" >> "$SHELL_RC"

# --- Done ---
echo ""
echo "  ✓ Installed!"
echo ""
echo "  AI Essentials"
echo "  ─────────────"
echo "  c            Claude Code"
echo "  g            Gemini CLI"
echo "  ai ...       Quick question to Claude"
echo "  gi ...       Quick question to Gemini"
[ -n "$CITY_SLUG" ] && echo "  weather      Weather for $CITY"
[ -n "$CITY_SLUG" ] && echo "  forecast     Forecast for $CITY"
echo ""
echo "  Coppermind CMO"
echo "  ──────────────"
echo "  cmo          All commands"
echo "  cmo-clients  Switch between clients"
echo "  cmo-prep     Meeting prep"
echo "  cmo-brief    Daily briefing"
echo ""
echo "  Open a new terminal or run: source $SHELL_RC"
echo ""
