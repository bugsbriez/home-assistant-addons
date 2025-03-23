ARG BUILD_ARCH
ARG BUILD_VERSION
ARG BUILD_BASE_IMAGE=zabbix/zabbix-proxy:alpine-7.0-latest

FROM ${BUILD_BASE_IMAGE} AS builder


FROM  ghcr.io/hassio-addons/base:17.2.1

LABEL org.opencontainers.image.authors="Benoit SAGE <bugs@hors-sujet.com>" \
      org.opencontainers.image.url="https://github.com/bugsbriez/home-assistant-addons/tree/main/zabbix-proxy" \
      org.opencontainers.image.title="Zabbix Proxy image for Home Assistant Add-on" \
      org.opencontainers.image.base.name="alpine"

ENV LANG=C.UTF-8

# Copy data for add-on
RUN apk add --no-cache jq zabbix-sqlite && \
    addgroup -g 102 docker && \
    addgroup zabbix docker

COPY rootfs /