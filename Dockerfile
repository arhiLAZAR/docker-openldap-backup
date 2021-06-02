FROM ubuntu:18.04

ARG OPENLDAP_PACKAGE_VERSION=2.4.45
ARG RCLONE_PACKAGE_VERSION=v1.55.1

ADD https://downloads.rclone.org/${RCLONE_PACKAGE_VERSION}/rclone-${RCLONE_PACKAGE_VERSION}-linux-amd64.zip /tmp/rclone.zip
COPY rclone.conf /root/.config/rclone/rclone.conf

COPY scripts/save_subtree.sh /usr/local/bin/save_subtree
COPY scripts/upload_backup.sh /usr/local/bin/upload_backup
COPY scripts/download_backup.sh /usr/local/bin/download_backup
COPY scripts/restore_backup.sh /usr/local/bin/restore_backup

RUN apt-get -y update && \
apt-get install -y --no-install-recommends \
ldap-utils=${OPENLDAP_PACKAGE_VERSION}\* \
curl \
ca-certificates \
unzip && \
unzip /tmp/rclone.zip -d /tmp && \
mv /tmp/rclone-${RCLONE_PACKAGE_VERSION}-linux-amd64/rclone /usr/local/bin/rclone && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
