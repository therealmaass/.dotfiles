#!/bin/bash

source ~/.config/restic/restic_env.sh

echo "-"
echo "-"
echo "Initializing new repo"
echo "---------------------------"

restic init

echo ""
echo "Finished initializing $(date)"
echo "---------------------------"
