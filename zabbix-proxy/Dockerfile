ARG BUILD_ARCH
ARG BUILD_VERSION
ARG BUILD_BASE_IMAGE=zabbix/zabbix-proxy:alpine-7.0-latest

FROM ${BUILD_BASE_IMAGE} as builder

FROM alpine

LABEL org.opencontainers.image.authors="Benoit SAGE <bugs@hors-sujet.com>" \
      org.opencontainers.image.url="https://github.com/bugsbriez/home-assistant-addons/tree/main/zabbix-proxy" \
      org.opencontainers.image.title="Zabbix Proxy image for Home Assistant Add-on" \
      org.opencontainers.image.base.name="alpine"

ENV LANG C.UTF-8

# Copy data for add-on
COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
