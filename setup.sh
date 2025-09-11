#!/data/data/com.termux/files/usr/bin/bash
# 🚀 Termux Ultimate + Android Dev Environment (All-in-One)
# รวม Update / Essentials / Oh My Zsh / Autojump / Node / PNPM / Java / Gradle / Android SDK
# ARM64 / Android 7+ / Termux

set -euo pipefail

echo "🔄 Starting Termux Ultimate + Android Dev Setup..."

HOME_DIR="$HOME"
REPO_DIR="$HOME_DIR/termux-ultimate-setup"
SCRIPTS_DIR="$REPO_DIR/scripts"

# -------------------------------
# 1️⃣ Update & install packages safely
# -------------------------------
echo "🔹 Updating Termux packages..."
if command -v pkg >/dev/null 2>&1; then
    pkg update -y && pkg upgrade -y
else
    echo "⚠️ pkg command not found, skipping update."
fi

echo "🔹 Installing essentials..."
for p in git curl wget zsh python nodejs-lts build-essential openjdk-17 unzip nano android-tools; do
    if ! command -v $p >/dev/null 2>&1; then
        pkg install -y "$p"
    else
        echo "ℹ️ $p already installed."
    fi
done

# -------------------------------
# 2️⃣ Install Oh My Zsh + Plugins
# -------------------------------
echo "💡 Installing Oh My Zsh..."
if [ ! -d "$HOME_DIR/.oh-my-zsh" ]; then
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
else
    echo "ℹ️ Oh My Zsh already installed."
fi

echo "🔌 Adding Zsh plugins..."
plugins_dir="$HOME_DIR/.oh-my-zsh/custom/plugins"
mkdir -p "$plugins_dir"

declare -A plugins_repo=(
    [zsh-autosuggestions]="https://github.com/zsh-users/zsh-autosuggestions"
    [zsh-syntax-highlighting]="https://github.com/zsh-users/zsh-syntax-highlighting"
    [zsh-completions]="https://github.com/zsh-users/zsh-completions"
    [autojump]="https://github.com/wting/autojump"
)

for plugin in "${!plugins_repo[@]}"; do
    target="$plugins_dir/$plugin"
    if [ ! -d "$target" ]; then
        git clone "${plugins_repo[$plugin]}" "$target"
    else
        echo "ℹ️ Plugin $plugin already exists."
    fi
done

# -------------------------------
# 3️⃣ Banner + Zsh configuration
# -------------------------------
echo "🎨 Setting custom banner..."
mkdir -p "$HOME_DIR/.config"
[ -f banner.txt ] && cp banner.txt "$HOME_DIR/.config/termux-banner.txt"

echo "⚙️ Configuring Zsh..."
cat > "$HOME_DIR/.zshrc" <<'EOF'
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="avit"

# Plugins
plugins=(git npm zsh-autosuggestions zsh-syntax-highlighting zsh-completions autojump)
source $ZSH/oh-my-zsh.sh

# Autojump safely
if [[ -s /data/data/com.termux/files/usr/share/autojump/autojump.zsh ]]; then
    source /data/data/com.termux/files/usr/share/autojump/autojump.zsh
fi

# Source custom aliases if exist
if [ -f "$HOME/termux-ultimate-setup/aliases.zsh" ]; then
    source <(grep -v '^alias j=' "$HOME/termux-ultimate-setup/aliases.zsh")
fi

# Source scripts helpers
SCRIPTS_DIR="$HOME/termux-ultimate-setup/scripts"
[ -f "$SCRIPTS_DIR/cleanup.sh" ] && alias cleanup="bash $SCRIPTS_DIR/cleanup.sh"
[ -f "$SCRIPTS_DIR/fix-lightningcss.sh" ] && alias fix_css="bash $SCRIPTS_DIR/fix-lightningcss.sh"
[ -f "$SCRIPTS_DIR/termux-fix.sh" ] && alias termux_fix="bash $SCRIPTS_DIR/termux-fix.sh"
[ -f "$SCRIPTS_DIR/backup-projects.sh" ] && alias backuppj="bash $SCRIPTS_DIR/backup-projects.sh"
[ -f "$SCRIPTS_DIR/backup-projectsDEV.sh" ] && alias backupDEV="bash $SCRIPTS_DIR/backup-projectsDEV.sh"

# Display banner
[ -f "$HOME/.config/termux-banner.txt" ] && cat "$HOME/.config/termux-banner.txt"

# Node & NVM helpers
export PATH="$HOME/bin:$PATH:$HOME/.npm-global/bin"
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"

# Git branch prompt
autoload -U colors && colors
git_branch_prompt() { git rev-parse --abbrev-ref HEAD 2>/dev/null | sed "s/^/ /"; }
PROMPT='%F{magenta}TERMUX%f %F{blue}%~%f $(git_branch_prompt) %# '

# LightningCSS / Rollup fix
export VITE_DISABLE_LIGHTNING_CSS=true

# Android Environment
export ANDROID_HOME="$PREFIX/opt/Android/sdk"
export ANDROID_SDK_ROOT="$ANDROID_HOME"
export PATH="$PATH:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/platform-tools:$ANDROID_HOME/build-tools/35.0.2"
export JAVA_HOME="/data/data/com.termux/files/usr/lib/jvm/java-17-openjdk"
export GRADLE_HOME="$PREFIX/opt/gradle"
export PATH="$PATH:$GRADLE_HOME/bin"
EOF

# -------------------------------
# 4️⃣ Hide login messages
# -------------------------------
touch "$HOME_DIR/.hushlogin"

# -------------------------------
# 5️⃣ Ensure scripts are executable
# -------------------------------
echo "🔧 Setting execute permission for scripts..."
if [ -d "$SCRIPTS_DIR" ]; then
    chmod +x "$SCRIPTS_DIR"/*.sh
fi

# -------------------------------
# 6️⃣ Install PNPM if missing
# -------------------------------
if ! command -v pnpm >/dev/null 2>&1; then
    echo "📦 Installing PNPM..."
    curl -fsSL https://get.pnpm.io/install.sh | bash
    export PATH="$HOME_DIR/.local/share/pnpm:$PATH"
fi

# -------------------------------
# 7️⃣ Android Build Environment
# -------------------------------
echo "📱 Installing Android Build Environment..."
curl -O https://raw.githubusercontent.com/ahksoft/termux-android-build-environment/main/android_env_bash.sh
chmod +x android_env_bash.sh
./android_env_bash.sh

# -------------------------------
# 8️⃣ Finish setup
# -------------------------------
echo "✅ Termux Ultimate + Android Dev Setup complete!"
echo "💡 To reload Zsh now: exec zsh"
echo "💡 Aliases ready: cleanup / fix_css / termux_fix / backuppj / backupDEV"
echo "💡 Autojump ready: use 'j <folder>'"
echo "💡 LightningCSS disabled for Termux"
echo "💡 Android SDK & Gradle ready for build"