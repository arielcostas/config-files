#!/bin/bash

# Set variables
DB_USER="<REDACTED>"
DB_PASS="<REDACTED>"
DB_NAME="<REDACTED>"
DATE=$(date +%Y-%m-%d_%H-%M-%S)
BACKUP_DIR="/opt/backups"
BACKUP_FILE="$BACKUP_DIR/$DB_NAME-$DATE.sql"
FILENAME="$DB_NAME-$DATE.tar.zst"
TAR_FILE="$BACKUP_DIR/$FILENAME"
SAS_FILE="$BACKUP_DIR/sas.txt"

# Dump the database
mysqldump -u $DB_USER -p$DB_PASS $DB_NAME > $BACKUP_FILE

# Check if the --full argument was passed and add assets folder to the archive if it was
if [[ "$1" == "--full" ]]; then
    tar --zstd -cvf $TAR_FILE $BACKUP_FILE /opt/vigo360/assets
else
    tar --zstd -cvf $TAR_FILE $BACKUP_FILE
fi

# Remove the backup file
rm $BACKUP_FILE

az storage blob upload --account-name vigo360backup --sas-token $(cat $SAS_FILE) -c backups -n $FILENAME -f $TAR_FILE

rm $TAR_FILE