# ============================================================
#  cmo-kit — AI Shortcuts for CMOs (Windows PowerShell)
#  https://github.com/benfinklea/cmo-kit
#
#  Install:
#    irm https://raw.githubusercontent.com/benfinklea/cmo-kit/main/install.ps1 | iex
#
#  Uninstall:
#    Remove the "cmo-kit" block from your $PROFILE
# ============================================================

# Ensure profile exists
if (!(Test-Path -Path $PROFILE)) {
    New-Item -ItemType File -Path $PROFILE -Force | Out-Null
}

# Check if already installed
if (Select-String -Path $PROFILE -Pattern "cmo-kit" -Quiet) {
    Write-Host "cmo-kit is already installed in $PROFILE"
    Write-Host "To reinstall, first remove the 'cmo-kit' block from that file."
    exit
}

Write-Host ""
Write-Host "  cmo-kit - AI Shortcuts for CMOs"
Write-Host "  ────────────────────────────────"
Write-Host ""
$City = Read-Host "  City for weather shortcut (e.g. Austin, London) [skip]"
$CitySlug = $City -replace ' ', '_'

Write-Host ""
Write-Host "  Installing to $PROFILE ..."

$block = @'

# ── cmo-kit — AI Shortcuts for CMOs ──────────────────
# https://github.com/benfinklea/cmo-kit

# ─── AI essentials ───
function c { claude @args }
function g { gemini @args }
function ai { claude -p ($args -join ' ') }
function gi { gemini -p ($args -join ' ') }

# ─── Coppermind CMO ───
function _coppermind_check {
    $null = pip show coppermind-cmo 2>$null
    if ($LASTEXITCODE -eq 0) { return $true }
    Write-Host ""
    Write-Host "  ┌─────────────────────────────────────────────────────┐"
    Write-Host "  │  Coppermind CMO — AI memory for fractional CMOs     │"
    Write-Host "  │                                                     │"
    Write-Host "  │  Switch clients in seconds. Never lose context.     │"
    Write-Host "  │  Hand off a complete AI brain when engagements end. │"
    Write-Host "  │                                                     │"
    Write-Host "  │  Request beta access → ben@volacci.com              │"
    Write-Host "  └─────────────────────────────────────────────────────┘"
    Write-Host ""
    return $false
}

function cmo {
    if (!(_coppermind_check)) { return }
    Write-Host ""
    Write-Host "  Coppermind CMO"
    Write-Host "  ──────────────"
    Write-Host "  cmo-clients   Switch between clients"
    Write-Host "  cmo-prep      Meeting prep for active client"
    Write-Host "  cmo-brief     Daily client briefing"
    Write-Host ""
}

function cmo-clients {
    if (!(_coppermind_check)) { return }
    claude "Show my client list using list_minds. Display as a numbered list with each client's name and last activity. Then ask which one I want to switch to."
}

function cmo-prep {
    if (!(_coppermind_check)) { return }
    claude "Run meeting prep for my active client. Check my calendar for the next meeting, pull relevant memories, and build a briefing with key context, open items, and talking points."
}

function cmo-brief {
    if (!(_coppermind_check)) { return }
    claude "Give me my daily CMO briefing. For each active client: last meeting takeaways, open action items, upcoming meetings, and anything that needs attention today."
}

'@

if ($CitySlug) {
    $block += @"

function weather { (Invoke-WebRequest -Uri "https://wttr.in/${CitySlug}?format=3" -UseBasicParsing).Content }
function forecast { (Invoke-WebRequest -Uri "https://wttr.in/${CitySlug}" -UseBasicParsing).Content }
"@
}

$block += "`n`n# ── end cmo-kit ────────────────────────────────────`n"

Add-Content -Path $PROFILE -Value $block

Write-Host ""
Write-Host "  Done! Shortcuts installed."
Write-Host ""
Write-Host "  AI Essentials"
Write-Host "  ─────────────"
Write-Host "  c            Claude Code"
Write-Host "  g            Gemini CLI"
Write-Host "  ai ...       Quick question to Claude"
Write-Host "  gi ...       Quick question to Gemini"
if ($CitySlug) {
    Write-Host "  weather      Weather for $City"
    Write-Host "  forecast     Forecast for $City"
}
Write-Host ""
Write-Host "  Coppermind CMO"
Write-Host "  ──────────────"
Write-Host "  cmo          All commands"
Write-Host "  cmo-clients  Switch between clients"
Write-Host "  cmo-prep     Meeting prep"
Write-Host "  cmo-brief    Daily briefing"
Write-Host ""
Write-Host "  Restart your terminal or run: . `$PROFILE"
Write-Host ""
