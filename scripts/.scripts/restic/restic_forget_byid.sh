#!/bin/bash

# run unlock script first (includes setting env vars)
source ~/.config/restic/restic_env.sh

echo "-"
echo "-"
echo "Forgetting snapshot with id: $1... ($(date))..."
echo "---------------------------"

restic forget $1

echo ""
echo "Finished forgetting $(date)"
echo "---------------------------"
