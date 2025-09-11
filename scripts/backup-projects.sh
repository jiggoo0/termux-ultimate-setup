#!/data/data/com.termux/files/usr/bin/bash
# 📦 Backup projects folder → ~/BackupPJ (ไม่รวม node_modules และ .git)
# เมื่อครบ 5 ไฟล์ zip จะ push ไป GitHub repo termux-ultimate-setup แล้วล้างไฟล์เก่า

set -e

PROJECTS_DIR=~/projects
BACKUP_DIR=~/BackupPJ
REPO_DIR=~/termux-ultimate-setup
TIMESTAMP=$(date +%F-%H%M%S)
ZIP_FILE="$BACKUP_DIR/projects-$TIMESTAMP.zip"

# -------------------------------
# 1️⃣ สร้างโฟลเดอร์ BackupPJ ถ้ายังไม่มี
# -------------------------------
mkdir -p "$BACKUP_DIR"

# -------------------------------
# 2️⃣ บีบอัดโฟลเดอร์ projects (ไม่รวม node_modules และ .git)
# -------------------------------
echo "📦 Creating backup: $ZIP_FILE"
cd "$PROJECTS_DIR"
zip -r "$ZIP_FILE" . -x "node_modules/*" -x ".git/*" >/dev/null

# -------------------------------
# 3️⃣ นับจำนวนไฟล์ใน BackupPJ
# -------------------------------
COUNT=$(ls -1 "$BACKUP_DIR"/*.zip 2>/dev/null | wc -l)
echo "📊 Current backups in $BACKUP_DIR: $COUNT file(s)"

# -------------------------------
# 4️⃣ ถ้าเกินหรือเท่ากับ 5 → ย้ายไป repo + commit/push + ล้างไฟล์ใน BackupPJ
# -------------------------------
if [ "$COUNT" -ge 5 ]; then
    echo "🚀 Backup limit reached (>=5). Pushing to GitHub repo..."

    mkdir -p "$REPO_DIR/backup"
    mv "$BACKUP_DIR"/*.zip "$REPO_DIR/backup/"

    cd "$REPO_DIR"
    git add backup/
    git commit -m "📦 Auto backup projects at $TIMESTAMP"
    git push origin main

    echo "✅ Backups pushed to GitHub!"

    echo "🧹 Cleaning $BACKUP_DIR..."
    rm -f "$BACKUP_DIR"/*.zip
    echo "✅ Backup folder cleaned!"
else
    echo "ℹ️ Less than 5 backups. Skipping push."
fi