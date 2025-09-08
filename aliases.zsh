# ------------------------------
# Termux Ultimate Setup Aliases
# ------------------------------

# Package management
alias update="pkg update && pkg upgrade -y"
alias install="pkg install -y"
alias remove="pkg uninstall -y"

# Git shortcuts
alias gs="git status"
alias ga="git add"
alias gc="git commit -m"
alias gp="git push"
alias gl="git pull"
alias gco="git checkout"
alias gb="git branch"
alias gpo="git push origin"
alias gpl="git pull origin"

# Navigation / Project shortcuts
alias proj="cd ~/project"
alias home="cd ~"
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Autojump integration
alias j="autojump"

# Node / PNPM helpers
alias npmi="pnpm install"
alias npmg="pnpm install -g"
alias npmu="pnpm uninstall"
alias pt="pnpm run start"
alias pd="pnpm run dev"
alias pb="pnpm run build"
alias pf="pnpm run format"
alias phc="pnpm type-check"
alias pck="scripts/check-structure.sh"
alias pbu="scripts/backup-project.sh"

# Utility / system
alias ll="ls -lah"
alias la="ls -A"
alias l="ls -CF"
alias cls="clear"
alias h="history"
alias path="echo $PATH"

# Termux / Dev shortcuts
alias restart_termux="termux-reload-settings && exec zsh"
alias backup_config="~/termux-ultimate-setup/scripts/backup-config.sh"
alias fix_css="~/termux-ultimate-setup/scripts/fix-lightningcss.sh"
alias cleanup="~/termux-ultimate-setup/scripts/cleanup.sh"

# Quick function
mkcd() { mkdir -p "$1" && cd "$1"; }