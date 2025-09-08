#!/data/data/com.termux/files/usr/bin/bash
# 🚀 Termux Ultimate Setup (Auto Banner + Zsh + Autojump + LightningCSS fix)

set -e

echo "🔄 Updating Termux packages..."
pkg update -y && pkg upgrade -y

echo "📦 Installing essentials..."
pkg install -y git curl wget zsh python nodejs-lts build-essential

echo "💡 Installing Oh My Zsh..."
rm -rf ~/.oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

echo "🔌 Adding plugins..."
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/wting/autojump ~/.oh-my-zsh/custom/plugins/autojump

echo "🎨 Setting custom banner..."
mkdir -p ~/.config
cp banner.txt ~/.config/termux-banner.txt

echo "⚙️ Configuring Zsh + Auto Banner..."
cat > ~/.zshrc <<'EOF'
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="avit"
plugins=(git npm zsh-autosuggestions zsh-syntax-highlighting zsh-completions autojump)
source $ZSH/oh-my-zsh.sh
[[ -s /data/data/com.termux/files/usr/share/autojump/autojump.zsh ]] && source /data/data/com.termux/files/usr/share/autojump/autojump.zsh

# Display custom banner
[ -f ~/.config/termux-banner.txt ] && cat ~/.config/termux-banner.txt

# Node & PNPM helpers
export PATH="$HOME/bin:$PATH:$HOME/.npm-global/bin"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Prompt with Git branch
autoload -U colors && colors
git_branch_prompt() { git rev-parse --abbrev-ref HEAD 2>/dev/null | sed "s/^/ /"; }
PROMPT='%F{magenta}TERMUX%f %F{blue}%~%f $(git_branch_prompt) %# '

# LightningCSS / Rollup fix for Termux
export VITE_DISABLE_LIGHTNING_CSS=true
EOF

echo "🛑 Hiding default Termux login messages..."
touch ~/.hushlogin

echo "✅ Setup complete! Restart Termux or run: exec zsh"
echo "💡 Autojump enabled: use 'j <folder>'"
echo "💡 LightningCSS disabled for Termux (avoids Rollup ARM64 errors)"