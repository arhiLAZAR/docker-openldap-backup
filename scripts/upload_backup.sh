#!/bin/bash

unixtime=$(date +%s)
bucket=${RCLONE_S3_BUCKET_NAME:-openldap-backups}

cd "${BACKUP_TMP_DIR:-/tmp}"
tar -zvcf backup.tar.gz *.ldif

rclone mkdir s3:/${bucket}
rclone copy backup.tar.gz s3:/${bucket}/${unixtime}
rclone copy backup.tar.gz s3:/${bucket}/latest
