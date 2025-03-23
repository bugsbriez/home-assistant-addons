#!/usr/bin/env bashio

# Extract config data
ZABBIX_SERVER=$(bashio::config 'server')
ZABBIX_HOSTNAME=$(bashio::config 'hostname')
ZABBIX_TLSPSK_IDENTITY=$(bashio::config 'tlspskidentity')
ZABBIX_TLSPSK_SECRET=$(bashio::config 'tlspsksecret')
ZABBIX_USER_PARAMETER=$(bashio::config 'userparameter')

# Update zabbix-proxy config
ZABBIX_CONFIG_FILE=/etc/zabbix/zabbix_proxy.conf
sed -i 's@^\(Server\)=.*@\1='"${ZABBIX_SERVER}"'@' "${ZABBIX_CONFIG_FILE}"
sed -i 's@^#\?\s\?\(Hostname\)=.*@\1='"${ZABBIX_HOSTNAME}"'@' "${ZABBIX_CONFIG_FILE}"

# Add TLS PSK config if variables are used
if [ "${ZABBIX_TLSPSK_IDENTITY}" != "null" ] && [ "${ZABBIX_TLSPSK_SECRET}" != "null" ]; then
  ZABBIX_TLSPSK_SECRET_FILE=/etc/zabbix/tls_secret
  echo "${ZABBIX_TLSPSK_SECRET}" > "${ZABBIX_TLSPSK_SECRET_FILE}"
  sed -i 's@^#\?\s\?\(TLSConnect\)=.*@\1='"psk"'@' "${ZABBIX_CONFIG_FILE}"
  sed -i 's@^#\?\s\?\(TLSAccept\)=.*@\1='"psk"'@' "${ZABBIX_CONFIG_FILE}"
  sed -i 's@^#\?\s\?\(TLSPSKIdentity\)=.*@\1='"${ZABBIX_TLSPSK_IDENTITY}"'@' "${ZABBIX_CONFIG_FILE}"
  sed -i 's@^#\?\s\?\(TLSPSKFile\)=.*@\1='"${ZABBIX_TLSPSK_SECRET_FILE}"'@' "${ZABBIX_CONFIG_FILE}"
fi
unset ZABBIX_TLSPSK_IDENTITY
unset ZABBIX_TLSPSK_SECRET

if [ "${ZABBIX_USER_PARAMETER}" != "null" ]; then
  sed -i 's@^#\?\s\?\(UserParameter\)=.*@\1='"${ZABBIX_USER_PARAMETER}"'@' "${ZABBIX_CONFIG_FILE}"
fi

# Run zabbix-proxy in foreground
exec su zabbix -s /bin/ash -c "zabbix_proxy -f"