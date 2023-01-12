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
#----------------------------------------------------------------
# run repo(includes setting env vars)
echo "-"
echo "-"
echo "Loading env varibles for restic"
echo "---------------------------"
source ~/.config/restic/restic_env.sh

#Set backup dir for database dumps
DB_BACKUP_DIR=/tmp/db_backup
DB_BACKUP_DAYS=2
#Set backups dirs for restic
CONTAINER_DATA_DIRS="$RESTIC_INCLUDE_PATHS $DB_BACKUP_DIR"

echo "-"
echo "-"
echo "Running scheduled backup ($(date))..."
echo "---------------------------"
# Identify which containers are database container and which are not
CONTAINER=$(docker ps --format '{{.Names}}:{{.Image}}' | grep -v 'mysql\|mariadb' | cut -d":" -f1)
DB_CONTAINER=$(docker ps --format '{{.Names}}:{{.Image}}' | grep 'mysql\|mariadb' | cut -d":" -f1)

# Create DB_BACKUP_DIR if not
if [ ! -d $DB_BACKUP_DIR ]; then
    mkdir -p $DB_BACKUP_DIR
fi

if [[ $(echo "$DB_CONTAINER" | wc -l) -ge 1 ]]; then
    

    for i in $DB_CONTAINER; do
        MYSQL_DATABASE=$(docker exec $i env | grep MYSQL_DATABASE |cut -d"=" -f2)
        MYSQL_PWD=$(docker exec $i env | grep MYSQL_ROOT_PASSWORD |cut -d"=" -f2)

        docker exec -e MYSQL_DATABASE=$MYSQL_DATABASE -e MYSQL_PWD=$MYSQL_PWD \
            $i /usr/bin/mysqldump -u root $MYSQL_DATABASE \
            | gzip > $DB_BACKUP_DIR/$i-$MYSQL_DATABASE-$(date +"%Y%m%d%H%M").sql.gz

        OLD_BACKUPS=$(ls -1 $DB_BACKUP_DIR/$i*.gz |wc -l)
        if [ $OLD_BACKUPS -gt $DB_BACKUP_DAYS ]; then
            find $DB_BACKUP_DIR -name "$i*.gz" -daystart -mtime +$DB_BACKUP_DAYS -delete
        fi
    done
fi

# Create backup of docker containers that are not DB container ( mysql / mariddb)

echo $CONTAINER

for i in $CONTAINER; do
    docker stop $i
done

echo "-"
echo "-"
echo "Running scheduled backup ($(date))..."
echo "---------------------------"
restic backup $CONTAINER_DATA_DIRS --tag $(hostname)
restic forget --prune --tag $(hostname) --keep-within 14d 

sleep 10

for i in $CONTAINER; do
    docker start $i
done

echo "$TIMESTAMP Backup completed"
echo ""
echo "Finished unlocking $(date)"
echo "---------------------------"
