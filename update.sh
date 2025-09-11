#!/data/data/com.termux/files/usr/bin/bash
# 🚀 Termux Ultimate Full Update + Backup + Cleanup + Android Dev Setup
# Usage: bash termux-full-update.sh

set -euo pipefail

REPO_DIR="$HOME/termux-ultimate-setup"
SETUP_SCRIPT="$REPO_DIR/setup.sh"
BACKUP_SCRIPT="$REPO_DIR/scripts/backup-projects.sh"
CLEANUP_SCRIPT="$REPO_DIR/scripts/cleanup.sh"
ANDROID_SCRIPT="$HOME/android_env_bash.sh"

echo "🔄 Starting Full Termux Ultimate + Android Dev Update..."

# -------------------------------
# 1️⃣ Update Repository
# -------------------------------
echo "📌 Updating termux-ultimate-setup repository..."
if [ ! -d "$REPO_DIR" ]; then
    echo "⚠️ Repository directory $REPO_DIR not found!"
    exit 1
fi
cd "$REPO_DIR"
if ! command -v git >/dev/null 2>&1; then
    echo "⚠️ Git not installed. Install git first."
    exit 1
fi
git pull origin main || echo "ℹ️ No updates or git pull failed. Continuing..."

# -------------------------------
# 2️⃣ Run setup.sh
# -------------------------------
if [ -f "$SETUP_SCRIPT" ]; then
    chmod +x "$SETUP_SCRIPT"
    echo "⚙️ Running setup.sh..."
    "$SETUP_SCRIPT"
fi

# -------------------------------
# 3️⃣ Backup Projects
# -------------------------------
if [ -f "$BACKUP_SCRIPT" ]; then
    chmod +x "$BACKUP_SCRIPT"
    echo "💾 Running backup script..."
    bash "$BACKUP_SCRIPT"
fi

# -------------------------------
# 4️⃣ Cleanup Termux
# -------------------------------
if [ -f "$CLEANUP_SCRIPT" ]; then
    chmod +x "$CLEANUP_SCRIPT"
    echo "🧹 Running cleanup script..."
    bash "$CLEANUP_SCRIPT"
fi

# -------------------------------
# 5️⃣ Install/Update Android Build Environment
# -------------------------------
echo "📱 Setting up Android Build Environment..."
if [ ! -f "$ANDROID_SCRIPT" ]; then
    curl -O https://raw.githubusercontent.com/ahksoft/termux-android-build-environment/main/android_env_bash.sh
    chmod +x android_env_bash.sh
fi
./android_env_bash.sh

# -------------------------------
# 6️⃣ Finish
# -------------------------------
echo "✅ Full Termux Ultimate + Android Dev Update Complete!"
echo "💡 Restart Termux or run: exec zsh"