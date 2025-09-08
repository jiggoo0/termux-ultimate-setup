#!/data/data/com.termux/files/usr/bin/bash
# 🧹 Termux Cleanup Script - Remove temp files & cache

set -e

echo "🧹 Cleaning Termux cache and temporary files..."

# Clear pkg cache
echo "🔹 Clearing package cache..."
pkg clean

# Remove Zsh cache
echo "🔹 Removing Zsh cache..."
rm -f ~/.zcompdump*

# Remove npm cache
echo "🔹 Clearing npm cache..."
npm cache clean --force

# Remove Python cache
echo "🔹 Removing Python __pycache__..."
find ~/ -type d -name "__pycache__" -exec rm -rf {} +

# Optional: Remove any log/temp files in home directory
echo "🔹 Removing temp/log files in ~/tmp and ~/logs if exist..."
[ -d ~/tmp ] && rm -rf ~/tmp/*
[ -d ~/logs ] && rm -rf ~/logs/*

echo "✅ Cleanup complete!"