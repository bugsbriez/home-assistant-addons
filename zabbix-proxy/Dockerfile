ARG BUILD_ARCH
ARG BUILD_VERSION
ARG BUILD_BASE_IMAGE=zabbix/zabbix-proxy:alpine-7.0-latest

FROM ${BUILD_BASE_IMAGE} AS builder


FROM  ghcr.io/hassio-addons/base:17.2.1

LABEL org.opencontainers.image.authors="Benoit SAGE <bugs@hors-sujet.com>" \
      org.opencontainers.image.url="https://github.com/bugsbriez/home-assistant-addons/tree/main/zabbix-proxy" \
      org.opencontainers.image.title="Zabbix Proxy image for Home Assistant Add-on" \
      org.opencontainers.image.base.name="alpine"

ENV LANG=C.UTF-8 \
    MIBDIRS=/usr/share/snmp/mibs:/var/lib/zabbix/mibs MIBS=+ALL \
    NMAP_PRIVILEGED="" \
    ZABBIX_USER_HOME_DIR="/var/lib/zabbix" \
    ZABBIX_CONF_DIR="/etc/zabbix" \
    ZBX_FPINGLOCATION="/usr/sbin/fping"

# Copy data for add-on
RUN apk add --no-cache jq zabbix-sqlite && \
    addgroup -g 102 docker && \
    mkdir -p ${ZABBIX_USER_HOME_DIR} && \
    mkdir -p ${ZABBIX_USER_HOME_DIR}/db_data && \
    mkdir -p ${ZABBIX_USER_HOME_DIR}/enc && \
    mkdir -p ${ZABBIX_USER_HOME_DIR}/enc_internal && \
    mkdir -p ${ZABBIX_USER_HOME_DIR}/mibs && \
    mkdir -p ${ZABBIX_USER_HOME_DIR}/modules && \
    mkdir -p ${ZABBIX_USER_HOME_DIR}/snmptraps && \
    mkdir -p ${ZABBIX_USER_HOME_DIR}/ssh_keys && \
    mkdir -p ${ZABBIX_USER_HOME_DIR}/ssl && \
    mkdir -p ${ZABBIX_USER_HOME_DIR}/ssl/certs && \
    mkdir -p ${ZABBIX_USER_HOME_DIR}/ssl/keys && \
    mkdir -p ${ZABBIX_USER_HOME_DIR}/ssl/ssl_ca && \
    mkdir -p /usr/lib/zabbix/externalscripts && \
    chown --quiet -R zabbix:root ${ZABBIX_CONF_DIR}/ ${ZABBIX_USER_HOME_DIR}/ && \
    chgrp -R 0 ${ZABBIX_CONF_DIR}/ ${ZABBIX_USER_HOME_DIR}/ && \
    chmod -R g=u ${ZABBIX_CONF_DIR}/ ${ZABBIX_USER_HOME_DIR}/ && \
    addgroup zabbix docker

COPY rootfs /