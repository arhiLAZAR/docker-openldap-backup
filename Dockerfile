FROM ubuntu:18.04

ARG OPENLDAP_PACKAGE_VERSION=2.4.45
ARG RCLONE_PACKAGE_VERSION=v1.55.1
ARG KUBECTL_VERSION=v1.20.4

ADD https://downloads.rclone.org/${RCLONE_PACKAGE_VERSION}/rclone-${RCLONE_PACKAGE_VERSION}-linux-amd64.zip /tmp/rclone.zip
ADD https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl /usr/local/bin/kubectl
COPY rclone.conf /root/.config/rclone/rclone.conf

COPY scripts/save_subtree.sh /usr/local/bin/save_subtree
COPY scripts/upload_backup.sh /usr/local/bin/upload_backup
COPY scripts/download_backup.sh /usr/local/bin/download_backup
COPY scripts/restore_backup.sh /usr/local/bin/restore_backup
COPY scripts/check_replication.sh /usr/local/bin/check_replication
COPY scripts/delete_helmrelease.sh /usr/local/bin/delete_helmrelease
COPY scripts/configure_kubectl.sh /usr/local/bin/configure_kubectl

RUN apt-get -y update && \
apt-get install -y --no-install-recommends \
ldap-utils=${OPENLDAP_PACKAGE_VERSION}\* \
curl \
ca-certificates \
unzip \
git && \
unzip /tmp/rclone.zip -d /tmp && \
mv /tmp/rclone-${RCLONE_PACKAGE_VERSION}-linux-amd64/rclone /usr/local/bin/rclone && \
chmod +x /usr/local/bin/kubectl && \
apt-get clean && \
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
