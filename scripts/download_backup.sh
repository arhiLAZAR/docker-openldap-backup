#!/bin/bash

bucket=${RCLONE_S3_BUCKET_NAME:-openldap-backups}
backup_name=${RCLONE_S3_BACKUP_NAME:-latest}

cd "${BACKUP_TMP_DIR:-/tmp}"

rclone copy s3:/${bucket}/${backup_name} ./

tar -zvxf backup.tar.gz
