#!/bin/bash
set -e

# Strip only the top domain to get the zone id
ZONE=$(echo "$CERTBOT_DOMAIN". | cut -d. -f2-)
DOMAIN=_acme-challenge.$(echo "$CERTBOT_DOMAIN" | cut -d. -f1)
echo "Domain is $DOMAIN in $ZONE"

# Create TXT record
if openstack recordset set "$ZONE" --type TXT "$DOMAIN" --record "$CERTBOT_VALIDATION" --ttl 60; then
	echo "Updated recordset"
else
	openstack recordset create "$ZONE" --type TXT "$DOMAIN" --record "$CERTBOT_VALIDATION" --ttl 60
	echo "Added recordset"
fi
echo "_acme-challenge created, waiting 25s for propagation"

# Sleep to make sure the change has time to propagate over to DNS
sleep 25
echo "handing back control to certbot"
