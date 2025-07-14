#!/bin/bash
if [ -z "$DOMAIN" ] || [ -z "$TARGETS" ] || [ -z "$BASIC_AUTH" ]; then
  source .env 2>/dev/null || { echo "env missing, check example"; exit 1; }
fi

VPNENDPOINT=$1
U=$2

[[ -z "$U" ]] && echo "usage: $(basename $0) endpoint username"  && exit 1


case ${VPNENDPOINT%%.*} in
  vpn-sa)
      COUNTRY="sa"
      ;;
  vpn-il)
      COUNTRY="il"
      ;;
  vpn-fr)
      COUNTRY="fr"
      ;;
  *)
      COUNTRY="de"
      ;;
esac

curl -s "http://${VPNENDPOINT}.${DOMAIN}/api/user/config/show" \
  -H 'Accept: application/json, text/plain, */*' \
  -H "Authorization: Basic ${BASIC_AUTH}" \
  -H 'Content-Type: application/x-www-form-urlencoded' \
  --compressed \
  --insecure \
  --data-raw 'username='$U > configs/${COUNTRY}-${U}.ovpn
echo "Downloaded as ${COUNTRY}-${U}.ovpn"
