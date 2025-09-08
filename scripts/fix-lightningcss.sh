#!/data/data/com.termux/files/usr/bin/bash
# ⚡ Termux LightningCSS / Rollup Fix

set -e

echo "⚡ Disabling LightningCSS for Termux builds..."

# Set environment variable to disable LightningCSS
export VITE_DISABLE_LIGHTNING_CSS=true

# Persist in ~/.zshrc if not already set
if ! grep -q "VITE_DISABLE_LIGHTNING_CSS" ~/.zshrc; then
    echo 'export VITE_DISABLE_LIGHTNING_CSS=true' >> ~/.zshrc
    echo "💡 Added export to ~/.zshrc for persistent fix"
fi

echo "✅ LightningCSS disabled for Termux (avoids Rollup ARM64 errors)"
echo "💡 Restart Termux or run: exec zsh"