#!/bin/bash

source ~/.config/restic/restic_env.sh

echo "-"
echo "-"
echo "Changing password"
echo "---------------------------"

restic key passwd

echo ""
