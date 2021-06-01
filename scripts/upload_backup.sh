#!/bin/bash

unixtime=$(date +%s)
bucket=${RCLONE_S3_BUCKET_NAME:-ldapbackups}

cd "${BACKUP_TMP_DIR:-/tmp}"
tar -zvcf tree.ldif.tar.gz tree.ldif

rclone mkdir s3:/${bucket}
rclone copy tree.ldif.tar.gz s3:/${bucket}/${unixtime}
rclone copy tree.ldif.tar.gz s3:/${bucket}/latest
