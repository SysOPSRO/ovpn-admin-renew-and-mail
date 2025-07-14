#!/bin/bash
#
# en-masse vpn cert renew
#
# requires sqlite and coreutils which are missing from core image
#
cd /etc/openvpn/easyrsa
# 2026-07-01
MINDATE=1782864000
# skip confirm
export EASYRSA_BATCH=true
echo 'select username from users;' | sqlite3 -batch pki/users.db | while read vpn_user; do
    EXPIRY=$(openssl x509 -in pki/issued/${vpn_user}.crt -noout -enddate | awk -F"=" '{ print $NF }')
    S_EXPIRY=$(echo "$EXPIRY" | xargs -I{} -r date +%s --date '{}')
    if [[ ${S_EXPIRY} -lt ${MINDATE} ]]; then
        echo "user ${vpn_user} expires : ${EXPIRY} - will renew ✅"
        ./pki/easyrsa renew ${vpn_user} nopass  > /dev/null
    else
        echo "user ${vpn_user} expires : ${EXPIRY} - won't renew ✋"
    fi
done