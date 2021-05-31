#!/bin/bash

subtree="$@"

ldapsearch -Z -x \
-H ${LDAP_HOST:-ldap://localhost:389} \
-o ldif-wrap=${LDIF_WRAP:-76} \
-w "${LDAP_ADMIN_PASSWORD}" \
-D "${LDAP_ADMIN_USER}" \
-b "${subtree}" \
>> "${BACKUP_TMP_DIR:-/tmp}/tree.ldif"
