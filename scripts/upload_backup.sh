#!/bin/bash

unixtime=$(date +%s)

cd "${BACKUP_TMP_DIR:-/tmp}"
tar -zvcf tree.ldif.tar.gz tree.ldif

rclone copy tree.ldif.tar.gz s3:/ldap_backups/${unixtime}/tree.ldif.tar.gz
