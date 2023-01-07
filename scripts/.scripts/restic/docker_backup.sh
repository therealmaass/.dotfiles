#!/bin/bash

# Docker Container Backup Script 
# ---
# This backup script can be used to automatically backup docker containers.
# The script stops the container and backups the persistent data via restic and rclone into a cloud.
#
# Requirements:
# - Installed restic 
# - Installed rclone
# - Setup a rclone configuration in ~/.config/rclone
# - Setup a restic reposority

RESTIC_PW_LOCATION=/foo/bar/restic-password
RESTIC_REPO_LOCATION=rclone:foo-bar:/data/backups/
CONTAINER_DATA_DIRS="/foo /bar/"

export RESTIC_PASSWORD_FILE=$RESTIC_PW_LOCATION
export RESTIC_REPOSITORY=$RESTIC_REPO_LOCATION

# backup all mysql/mariadb containers

CONTAINER=$(docker ps --format '{{.Names}}:{{.Image}}' | grep -v 'mysql\|mariadb' | cut -d":" -f1)


echo $CONTAINER

for i in $CONTAINER; do
    docker stop $i
done

restic backup $CONTAINER_DATA_DIRS --tag $(hostname)

sleep 10

for i in $CONTAINER; do
    docker start $i
done

echo "$TIMESTAMP Backup completed"
