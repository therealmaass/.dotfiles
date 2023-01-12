#!/bin/bash

# run unlock script first (includes setting env vars)
source ~/.config/restic/restic_env.sh

echo "-"
echo "-"
echo "Running scheduled backup ($(date))..."
echo "---------------------------"

restic -o b2.connections=$B2_CONNECTIONS backup --exclude-file=$RESTIC_EXCLUDE_FILE_PATH $RESTIC_INCLUDE_PATHS

echo ""
echo "Finished scheduled backup $(date)"
echo "---------------------------"
