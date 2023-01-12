#!/bin/bash

# run unlock script first (includes setting env vars)
source ~/.config/restic/restic_env.sh

echo "-"
echo "-"
echo "Policy: --keep-daily 30 --keep-weekly 8 --keep-monthly 12 --keep-yearly 100 --keep-last 4"
echo "Forgetting and pruning snapshots according to retention policy ($(date))..."
echo "---------------------------"

restic forget --keep-daily 30 --keep-weekly 8 --keep-monthly 12 --keep-yearly 100 --keep-last 4 --prune

echo ""
echo "Finished forget and prune $(date)"
echo "---------------------------"
