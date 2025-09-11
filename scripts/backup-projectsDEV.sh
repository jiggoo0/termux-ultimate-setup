#!/data/data/com.termux/files/usr/bin/bash
# 📦 Backup projects folder → /storage/emulated/0/BackupPJ (ไม่รวม node_modules และ .git)
# เมื่อครบ 5 ไฟล์ zip จะ push ไป GitHub repo termux-ultimate-setup แล้วล้างไฟล์เก่า

set -euo pipefail

# -------------------------------
# 1️⃣ Define directories
# -------------------------------
PROJECTS_DIR="${1:-$HOME/projects}"  # default: ~/projects
BACKUP_DIR="/storage/emulated/0/BackupPJ"  # external storage
REPO_DIR="$HOME/termux-ultimate-setup"
TIMESTAMP=$(date +%F-%H%M%S)
ZIP_FILE="$BACKUP_DIR/projects-$TIMESTAMP.zip"

# -------------------------------
# 2️⃣ Create Backup folder if missing
# -------------------------------
mkdir -p "$BACKUP_DIR"

# -------------------------------
# 3️⃣ Create zip (exclude node_modules and .git)
# -------------------------------
echo "📦 Creating backup: $ZIP_FILE"
cd "$PROJECTS_DIR"
zip -r "$ZIP_FILE" . -x "node_modules/*" -x ".git/*" >/dev/null
echo "✅ Backup created successfully!"

# -------------------------------
# 4️⃣ Count zip files
# -------------------------------
COUNT=$(ls -1 "$BACKUP_DIR"/*.zip 2>/dev/null | wc -l)
echo "📊 Current backups in $BACKUP_DIR: $COUNT file(s)"

# -------------------------------
# 5️⃣ Push if >=5 and clean
# -------------------------------
if [ "$COUNT" -ge 5 ]; then
    echo "🚀 Backup limit reached (>=5). Pushing to GitHub repo..."

    mkdir -p "$REPO_DIR/backup"
    mv "$BACKUP_DIR"/*.zip "$REPO_DIR/backup/"

    cd "$REPO_DIR"

    # ตรวจสอบว่า Git repo พร้อมใช้งาน
    if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        git add backup/
        git commit -m "📦 Auto backup projects at $TIMESTAMP"
        git push origin main
        echo "✅ Backups pushed to GitHub!"
    else
        echo "⚠️ Git repo not initialized in $REPO_DIR. Skipping push."
    fi

    # ล้างไฟล์เก่าใน BackupPJ
    echo "🧹 Cleaning $BACKUP_DIR..."
    rm -f "$BACKUP_DIR"/*.zip
    echo "✅ Backup folder cleaned!"
else
    echo "ℹ️ Less than 5 backups. Skipping push."
fi