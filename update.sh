#!/data/data/com.termux/files/usr/bin/bash
# 🔄 Update termux-ultimate-setup

set -e

REPO_DIR=~/termux-ultimate-setup

echo "📌 Updating repository..."
cd $REPO_DIR
git pull origin main

echo "🔄 Running setup.sh to apply updates..."
bash setup.sh

echo "✅ Update complete!"
echo "💡 Restart Termux or run: exec zsh"