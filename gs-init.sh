#!/bin/bash
PATH=/google-cloud-sdk/bin:$PATH
HOME="/"
BOTO_CONFIG="/.config/gcloud/legacy_credentials/brandon.risberg@gmail.com/.boto"

: "${GS_PROJECT_ID:?Need to set GS_PROJECT_ID}"
: "${APP_NAME:?Need to set APP_NAME}"

echo "Initializing $APP_NAME..."

BUCKET_NAME=${GS_PROJECT_ID}_${APP_NAME}_backups

if gsutil ls gs://$BUCKET_NAME 2>&1 >/dev/null | grep -q 'BucketNotFoundException: 404'; then
  # Creating Google Storage Bucket
  gsutil mb gs://$BUCKET_NAME
  echo "Done"
  gsutil versioning set on gs://$BUCKET_NAME
  echo "Done"
else
  echo "Using GS Bucket $BUCKET_NAME"
fi

# Setting bucket lifecycle policy
gsutil lifecycle set gs-lifecycle.json gs://$BUCKET_NAME
echo "Done"

cron && mongod
