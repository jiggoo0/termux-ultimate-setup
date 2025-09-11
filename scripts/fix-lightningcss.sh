#!/data/data/com.termux/files/usr/bin/bash
# ⚡ Termux LightningCSS / Rollup Fix (Safe & Verbose)

set -euo pipefail

echo "⚡ Disabling LightningCSS for Termux builds..."

# 1️⃣ Set environment variable for current session
export VITE_DISABLE_LIGHTNING_CSS=true
echo "🔹 VITE_DISABLE_LIGHTNING_CSS=true (current session)"

# 2️⃣ Persist in ~/.zshrc if not already set
ZSHRC="$HOME/.zshrc"
if [ -w "$ZSHRC" ]; then
    if ! grep -q "VITE_DISABLE_LIGHTNING_CSS" "$ZSHRC"; then
        echo 'export VITE_DISABLE_LIGHTNING_CSS=true' >> "$ZSHRC"
        echo "💡 Added export to ~/.zshrc for persistent fix"
    else
        echo "ℹ️ VITE_DISABLE_LIGHTNING_CSS already set in ~/.zshrc"
    fi
else
    echo "⚠️ Cannot write to $ZSHRC. Please add 'export VITE_DISABLE_LIGHTNING_CSS=true' manually."
fi

echo "✅ LightningCSS disabled for Termux (avoids Rollup ARM64 errors)"
echo "💡 Restart Termux or run: exec zsh to apply persistent changes"