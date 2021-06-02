#!/bin/bash

filename="${1}"
user="${2:-admin}"

if [[ "${LDAP_STARTTLS}" == "true" ]]; then
  tls_flag="-Z"
fi

if [[ "${user}" == "config" ]]; then
  ldapadd ${tls_flag} -x -c \
  -H ${LDAP_HOST:-ldap://localhost:389} \
  -o ldif-wrap=${LDIF_WRAP:-76} \
  -w "${LDAP_CONFIG_PASSWORD}" \
  -D "${LDAP_CONFIG_USER:-cn=admin,cn=config}" \
  -f "${filename}"
else
  ldapadd ${tls_flag} -x -c \
  -H ${LDAP_HOST:-ldap://localhost:389} \
  -o ldif-wrap=${LDIF_WRAP:-76} \
  -w "${LDAP_ADMIN_PASSWORD}" \
  -D "${LDAP_ADMIN_USER}" \
  -f "${filename}"
fi
