#!/bin/bash

if [[ "${LDAP_STARTTLS}" == "true" ]]; then
  tls_flag="-Z"
fi

lines_on_master=$(ldapsearch ${tls_flag} -x \
                  -H "${LDAP_MASTER_HOST}" \
                  -o ldif-wrap=${LDIF_WRAP:-76} \
                  -w "${LDAP_ADMIN_PASSWORD}" \
                  -D "${LDAP_ADMIN_USER}" \
                  -b "${LDAP_CHECK_AFTER_RESTORE_SUBTREE}" | wc -l)


lines_on_slave=$(ldapsearch ${tls_flag} -x \
                  -H "${LDAP_SLAVE_HOST}" \
                  -o ldif-wrap=${LDIF_WRAP:-76} \
                  -w "${LDAP_ADMIN_PASSWORD}" \
                  -D "${LDAP_ADMIN_USER}" \
                  -b "${LDAP_CHECK_AFTER_RESTORE_SUBTREE}" | wc -l)

if [[ $(($lines_on_master - $lines_on_slave)) -ge ${LDAP_CHECK_AFTER_RESTORE_AVAILABLE_DIFF:-100} ]]; then
  delete_helmrelease
fi
