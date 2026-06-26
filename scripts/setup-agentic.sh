#!/bin/bash
# Agentic toolchain — Kun Chen's AXI tools. OPTIONAL, advanced layer.
#
# All source repos were security-audited 2026-06-26 (findings in
# docs/MACOS-SETUP.md). We build from cloned SOURCE rather than `curl|sh` or
# `npx -y latest`, so you run the code that was reviewed.
#
# Prereqs: Node 20+, Go, gh (installed & `gh auth login`). Telemetry opt-outs
# (GNHF/NO_MISTAKES/LAVISH) already live in home/.zshrc.
#
# NOT -e: keep going if one tool fails to build.
set -uo pipefail

CODE="$HOME/code"
mkdir -p "$CODE" "$HOME/.local/bin"

clone() {  # clone (or skip if present) over HTTPS — SSH port 22 is flaky on some nets
  local name="$1"
  if [ -d "$CODE/$name/.git" ]; then
    echo "    $name already cloned"
  else
    git clone --depth 1 "https://github.com/kunchenguid/$name.git" "$CODE/$name"
  fi
}

echo "==> Cloning audited source repos"
for r in acpx no-mistakes gnhf lavish-axi firstmate axi; do clone "$r"; done

echo "==> no-mistakes (Go — build from source; source build bakes NO telemetry)"
# GODEBUG=http2client=0 dodges flaky-network HTTP/2 stream errors on large Go modules.
( cd "$CODE/no-mistakes" && GODEBUG=http2client=0 go build -o "$HOME/.local/bin/no-mistakes" ./cmd/no-mistakes \
  && echo "    installed: $($HOME/.local/bin/no-mistakes --version 2>&1 | head -1)" )

echo "==> gnhf / lavish-axi / acpx (npm — build from source + global link)"
for r in gnhf lavish-axi acpx; do
  ( cd "$CODE/$r" && npm install --no-fund --no-audit >/dev/null 2>&1 && npm run build >/dev/null 2>&1 \
    && npm link >/dev/null 2>&1 && echo "    linked: $r $(command -v $r >/dev/null && $r --version 2>&1 | head -1)" )
done

echo "==> Agent skills (install to ~/.agents/skills, symlinked into ~/.claude/skills)"
npx -y skills add kunchenguid/axi -g
for s in gh-axi tasks-axi chrome-devtools-axi; do
  npx -y skills add "kunchenguid/$s" --skill "$s" -g
done

# treehouse is installed (pinned + checksum-verified) by setup-macos.sh.

cat <<'NOTE'

==> Agentic toolchain done.
  - firstmate: no install — point an agent at ~/code/firstmate (AGENTS.md + skills).
  - acpx SAFETY: do NOT run `acpx config init` (it scaffolds an approve-all default);
    never run acpx inside an untrusted repo — its .acpxrc.json is auto-trusted and can
    redefine the launched command + auto-approve everything.
  - Telemetry is disabled via ~/.zshrc (GNHF_TELEMETRY / NO_MISTAKES_TELEMETRY / LAVISH_AXI_TELEMETRY).
NOTE
