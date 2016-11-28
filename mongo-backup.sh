#!/bin/bash
PATH=/google-cloud-sdk/bin:$PATH
HOME="/"
BOTO_CONFIG="/.config/gcloud/legacy_credentials/brandon.risberg@gmail.com/.boto"

: "${GS_PROJECT_ID:?Need to set GS_PROJECT_ID}"
: "${APP_NAME:?Need to set APP_NAME}"

echo "Hello World, from a shell script"
echo -n "Uploading to Google Cloud Storage..."
BUCKET_NAME=${GS_PROJECT_ID}_${APP_NAME}_backups
gsutil cp /var/log/cron.log gs://$BUCKET_NAME
echo "Done"
