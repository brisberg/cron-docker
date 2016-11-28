#!/bin/bash
PATH=/google-cloud-sdk/bin:$PATH
HOME="/"
BOTO_CONFIG="/.config/gcloud/legacy_credentials/brandon.risberg@gmail.com/.boto"

: "${GS_PROJECT_ID:?Need to set GS_PROJECT_ID}"
: "${APP_NAME:?Need to set APP_NAME}"

echo "Preparing backup dump file..."

FILE_NAME="mongo_dump"
ARCHIVE_NAME="$FILE_NAME.tar.gz"
BUCKET_NAME=${GS_PROJECT_ID}_${APP_NAME}_backups

# Lock the database
mongo admin --eval "printjson(db.fsyncLock());"

# Dump the database
mongodump --db=exampledb --out /var/backups/$FILE_NAME

# Unlock the database
mongo admin --eval "printjson(db.fsyncUnlock());"

# Tar Gzip the file
tar -C /var/backups/ -zcvf /var/backups/$ARCHIVE_NAME $FILE_NAME/

# Remove the backup directory
rm -r /var/backups/$FILE_NAME

echo "Uploading to Google Cloud Storage..."
gsutil cp /var/backups/$ARCHIVE_NAME gs://$BUCKET_NAME
rm /var/backups/$ARCHIVE_NAME
echo "Done"
