#!/bin/bash

source ~/.config/restic/restic_env.sh

echo "-"
echo "-"
echo "Listing current keys"
echo "---------------------------"

restic key list

echo ""
