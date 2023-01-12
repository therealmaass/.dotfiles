#!/bin/bash

# run unlock script first (includes setting env vars)
source ~/.config/restic/restic_unlock.sh

restic snapshots
