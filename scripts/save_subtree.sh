#!/bin/bash

subtree="$@"

if [[ "${LDAP_STARTTLS}" == "true" ]]; then
  tls_flag="-Z"
fi

if [[ "${subtree}" =~ .*___.*$ ]]; then
  attr=$(echo $subtree | awk -F '___' '{print $2}')
  subtree=$(echo $subtree | awk -F '___' '{print $1}')
fi

if [[ "$subtree" =~ .*,cn=config$ ]]; then
  ldapsearch ${tls_flag} -x \
  -H ${LDAP_MASTER_HOST:-ldap://localhost:389} \
  -o ldif-wrap=${LDIF_WRAP:-76} \
  -w "${LDAP_CONFIG_PASSWORD}" \
  -D "${LDAP_CONFIG_USER:-cn=admin,cn=config}" \
  -b "${subtree}" ${attr} \
  >> "${BACKUP_TMP_DIR:-/tmp}/config.ldif"
else
  ldapsearch ${tls_flag} -x \
  -H ${LDAP_MASTER_HOST:-ldap://localhost:389} \
  -o ldif-wrap=${LDIF_WRAP:-76} \
  -w "${LDAP_ADMIN_PASSWORD}" \
  -D "${LDAP_ADMIN_USER}" \
  -b "${subtree}" ${attr}\
  >> "${BACKUP_TMP_DIR:-/tmp}/tree.ldif"
fi
