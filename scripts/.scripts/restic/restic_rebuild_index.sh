#!/bin/bash

# run unlock script first (includes setting env vars)
source ~/.config/restic/restic_unlock.sh

echo "-"
echo "-"
echo "Rebuilding index ($(date))..."
echo "---------------------------"

restic rebuild-index

echo ""
echo "Finished rebuilding index $(date)"
echo "---------------------------"
