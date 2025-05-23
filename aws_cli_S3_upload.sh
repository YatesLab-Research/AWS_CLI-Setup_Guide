#!/bin/bash

# === CONFIGURATION ===
SOURCE_DIR="/path/to/your/source_directory"
DEST_S3="s3://your-bucket-name/your-destination-path/"
PROFILE="your-aws-cli-profile"

# === SIZE INFO ===
TOTAL_BYTES=$(du -sb "$SOURCE_DIR" | awk '{print $1}')
TOTAL_HUMAN=$(du -sh "$SOURCE_DIR" | awk '{print $1}')

echo -e "\n☕ Starting upload of $TOTAL_HUMAN...\n"

# === SYNC TO S3 WITH CHECKSUM VALIDATION ===
aws s3 sync "$SOURCE_DIR" "$DEST_S3" \
  --profile "$PROFILE" \
  --exact-timestamps \
  --checksum-algorithm SHA256 > upload.log 2>&1 &

AWS_PID=$!

# === WAIT FOR UPLOAD TO COMPLETE ===
if wait "$AWS_PID"; then
    echo -e "\n\033[1;32m✅ Upload complete successfully with SHA256 verification.\033[0m\n"
else
    echo -e "\n\033[1;31m❌ Upload failed. Check upload.log\033[0m\n"
fi
