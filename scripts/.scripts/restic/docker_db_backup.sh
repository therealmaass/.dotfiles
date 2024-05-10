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
DB_BACKUP_DIR=/tmp/db_backup
DB_BACKUP_DAYS=2

# backup all mysql/mariadb containers
# identify all postgres databases
DB_CONTAINER=$(docker ps --format '{{.Names}}:{{.Image}}' | grep 'postgres' | cut -d":" -f1)

# Create DB_BACKUP_DIR if not
if [ ! -d $DB_BACKUP_DIR ]; then
    mkdir -p $DB_BACKUP_DIR
fi

if [[ $(echo "$DB_CONTAINER" | wc -l) -ge 1 ]]; then
    

    for i in $DB_CONTAINER; do

        echo "TEST"
#        docker exec -e DB_CONTAINER=$DB_CONTAINER 
        echo "TEST2"
        docker exec -t $DB_CONTAINER pg_dumpall -U djangouser > $DB_BACKUP_DIR/$i-$(date +"%Y-%m-%d-%H_%M").sql
        echo "TEST3"


        OLD_BACKUPS=$(ls -1 $DB_BACKUP_DIR/$i*.sql |wc -l)
        if [ $OLD_BACKUPS -gt $DB_BACKUP_DAYS ]; then
            find $DB_BACKUP_DIR -name "$i*.gz" -daystart -mtime +$DB_BACKUP_DAYS -delete
        fi
    done
fi
