#!/data/data/com.termux/files/usr/bin/bash
# 🧹 Termux Cleanup Script - Remove temp files & cache
# Safe and verbose version

set -euo pipefail

echo "🧹 Starting Termux cleanup..."

# -------------------------------
# 1️⃣ Clear pkg cache
# -------------------------------
echo "🔹 Clearing package cache..."
if command -v pkg >/dev/null 2>&1; then
    pkg clean -y
else
    echo "⚠️ pkg command not found. Skipping..."
fi

# -------------------------------
# 2️⃣ Remove Zsh cache
# -------------------------------
echo "🔹 Removing Zsh cache..."
for f in ~/.zcompdump*; do
    [ -e "$f" ] && rm -v "$f"
done

# -------------------------------
# 3️⃣ Remove npm cache
# -------------------------------
echo "🔹 Clearing npm cache..."
if command -v npm >/dev/null 2>&1; then
    npm cache clean --force
else
    echo "⚠️ npm not installed. Skipping..."
fi

# -------------------------------
# 4️⃣ Remove Python cache
# -------------------------------
echo "🔹 Removing Python __pycache__ directories..."
find ~/ -type d -name "__pycache__" -print -exec rm -rf {} +

# -------------------------------
# 5️⃣ Remove optional temp/log directories
# -------------------------------
echo "🔹 Removing temp/log files in ~/tmp and ~/logs if exist..."
[ -d ~/tmp ] && rm -rv ~/tmp/* || echo "ℹ️ ~/tmp not found, skipping..."
[ -d ~/logs ] && rm -rv ~/logs/* || echo "ℹ️ ~/logs not found, skipping..."

# -------------------------------
# 6️⃣ Finish
# -------------------------------
echo "✅ Termux cleanup complete!"