#!/data/data/com.termux/files/usr/bin/bash
# ⏰ Schedule auto-backup using termux-job-scheduler

SCRIPT=~/termux-ultimate-setup/scripts/backup-projects.sh

if [ ! -f "$SCRIPT" ]; then
  echo "❌ Backup script not found at $SCRIPT"
  exit 1
fi

# ลบ job เดิมก่อน (ป้องกันซ้ำ)
termux-job-scheduler --cancel --job-id 1 2>/dev/null || true

# ตั้ง job ใหม่ให้รันทุก 6 ชั่วโมง
termux-job-scheduler \
  --job-id 1 \
  --script "$SCRIPT" \
  --period-ms 21600000 \
  --persisted true

echo "✅ Backup job scheduled every 6h"