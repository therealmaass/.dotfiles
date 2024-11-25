#!/bin/bash
/usr/bin/rclone mount sciebo-smaass: /mnt/sciebo-smaass --config /home/soeren/.config/rclone/rclone.conf --allow-non-empty --allow-other --log-level DEBUG --log-file /tmp/rclone.log

