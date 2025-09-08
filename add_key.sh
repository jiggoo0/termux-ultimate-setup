#!/data/data/com.termux/files/usr/bin/bash
# 🔑 Git HTTPS + Personal Access Token (PAT) Setup

set -e

echo "📌 Setting Git username and email..."
git config --global user.name "Jiggoo0"
git config --global user.email "jiggo0@outlook.co.th"

echo "🔒 Enabling credential helper (store)..."
git config --global credential.helper store

echo "💡 Current Git configuration:"
git config --list | grep -E "user|credential.helper"

echo ""
echo "✅ Git setup complete!"
echo "💡 To push first time: Username → GitHub username, Password → Personal Access Token (PAT)"