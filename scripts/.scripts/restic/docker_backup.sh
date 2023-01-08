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
RESTIC_PW_LOCATION=/foo/bar/restic-password
RESTIC_REPO_LOCATION=rclone:foo-bar:/data/backups/
CONTAINER_DATA_DIRS="/foo /bar/ $DB_BACKUP_DIR"

export RESTIC_PASSWORD_FILE=$RESTIC_PW_LOCATION
export RESTIC_REPOSITORY=$RESTIC_REPO_LOCATION

# backup all mysql/mariadb containers

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
            | gzip > $BACKUPDIR/$i-$MYSQL_DATABASE-$(date +"%Y%m%d%H%M").sql.gz

        OLD_BACKUPS=$(ls -1 $BACKUPDIR/$i*.gz |wc -l)
        if [ $OLD_BACKUPS -gt $DAYS ]; then
            find $BACKUPDIR -name "$i*.gz" -daystart -mtime +$DAYS -delete
        fi
    done
fi

# Create backup of docker containers that are not DB container ( mysql / mariddb)

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
