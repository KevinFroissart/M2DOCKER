#!/bin/bash

error() {
	printf "Error: %s\n" "$1"
	exit 1
}

[ -z "$CERTBOT_NAME" ] && error "CERTBOT_NAME is empty"
[ -z "$CERTBOT_DOMAIN" ] && error "CERTBOT_DOMAIN is empty"
[ -z "$CERTBOT_MAIL" ] && error "CERTBOT_MAIL is empty"
[ -z "$CERTBOT_IP" ] && error "CERTBOT_IP is empty"
[ -z "$CERTBOT_CONFIG" ] && error "CERTBOT_CONFIG is empty"

. $CERTBOT_CONFIG

openstack recordset create "$CERTBOT_DOMAIN". --type A "$CERTBOT_NAME" --record "$CERTBOT_IP"

FQDN="$CERTBOT_NAME"."$CERTBOT_DOMAIN"

TEST=
[ -n "$CERTBOT_TEST" ] && TEST=--test-cert
certbot certonly --manual --preferred-challenges=dns --manual-auth-hook /dns/authenticator.sh --manual-cleanup-hook /dns/cleanup.sh -d "$CERTBOT_NAME"."$CERTBOT_DOMAIN" --email "$CERTBOT_MAIL" --agree-tos --non-interactive $TEST

cp /etc/letsencrypt/live/"$FQDN"/* /cert -Lrv
