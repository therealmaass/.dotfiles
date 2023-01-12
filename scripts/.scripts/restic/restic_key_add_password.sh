#!/bin/bash

source ~/.config/restic/restic_env.sh

echo "-"
echo "-"
echo "Adding password"
echo "---------------------------"

restic key add

echo ""
