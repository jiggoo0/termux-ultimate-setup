# ------------------------------
# Termux Ultimate Setup Aliases
# ------------------------------

# Package management
alias update="pkg update && pkg upgrade -y"
alias install="pkg install -y"
alias remove="pkg uninstall -y"

# Git shortcuts
alias gs="git status"
alias ga="git add ."
alias gc='git commit -m "update dev bannban"'
alias gp="git push"
alias gl="git pull"
alias gco="git checkout"
alias gb="git branch"
alias gpo="git push origin"
alias gpl="git pull origin"

# DevSEO full workflow
alias devseo='git add . && pnpm lint-staged && git commit -m "update" && git push'

# Navigation / Project shortcuts
alias proj="cd ~/project"
alias home="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Autojump integration (safe)
if command -v autojump >/dev/null 2>&1; then
  alias j="autojump"
fi

# Node / PNPM helpers
alias npmi="pnpm install"
alias npmg="pnpm install -g"
alias npmu="pnpm uninstall"
alias pt="pnpm run start"
alias pd="pnpm run dev"
alias pb="pnpm run build"
alias pl="pnpm lint"
alias pf="pnpm format"
alias phc="pnpm check"
alias ptc="pnpm type-check"
alias ci="pnpm run ci"

alias pall='pnpm check && pnpm lint && pnpm alias:fix && pnpm alias:check'
alias pdp="pnpm run deploy"
alias pck="~/termux-ultimate-setup/scripts/check-structure.sh"
alias pbu="scripts/backup-project.sh"

# Dev Git/Project Toolkit
alias devtool="bash ~/tools/dev_git_tool.sh"

# Utility / system
alias ll="ls -lah"
alias la="ls -A"
alias l="ls -CF"
alias cls="clear"
alias h="history"
alias path="echo $PATH"

# Backup Projects → Zip + Push (เมื่อครบ 5 ไฟล์)
alias backuppj="~/termux-ultimate-setup/scripts/backup-projects.sh"
alias backupDEV="~/termux-ultimate-setup/scripts/backup-projectsDEV.sh"

# Termux / Dev shortcuts
alias restart_termux="termux-reload-settings && exec zsh"
alias backup_config="~/termux-ultimate-setup/scripts/backup-config.sh"
alias fix_css="~/termux-ultimate-setup/scripts/fix-lightningcss.sh"
alias cleanup="~/termux-ultimate-setup/scripts/cleanup.sh"

# Quick function
mkcd() { mkdir -p "$1" && cd "$1"; }