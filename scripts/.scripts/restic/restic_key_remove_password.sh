#!/bin/bash

source ~/.config/restic/restic_env.sh

echo "-"
echo "-"
echo "Removing password $1"
echo "---------------------------"

restic key remove $1

echo ""
