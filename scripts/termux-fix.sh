#!/data/data/com.termux/files/usr/bin/bash
# 🔧 Termux Fix Script - Refresh Zsh & Clear Cache

set -e

echo "🧹 Clearing Zsh cache..."
rm -f ~/.zcompdump*

echo "🔄 Reloading Zsh..."
exec zsh

echo "✅ Termux Zsh environment refreshed!"
echo "💡 All aliases, plugins, and banner should load correctly now."