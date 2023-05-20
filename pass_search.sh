#!/bin/bash
source .env

PASSWORK_TOKEN="${TOKEN10}"
if [[ $1 -lt 10 ]]; then # Меньше 10
    QUERY="{\"query\":\"$login\",\"vaultId\":\"$SeifID_back\",\"colors\":[12]}"
else
    QUERY="{\"query\":\"$login\",\"vaultId\":\"$SeifID_back\"}"
fi

PASS_search=$(curl -s -X POST "${HOST}/passwords/search" \
 -H "Accept: application/json" \
 -H "Passwork-Auth: ${PASSWORK_TOKEN}" \
 -H "Content-Type: application/json" \
 -d "${QUERY}")

echo -n "---Поиск---- Status: "
echo "$PASS_search" | jq -r '.status'
PASS_ID=$(echo "$PASS_search" | jq -r '.data[].id')
sed -i "/^PASS_ID_$login/d" /server/passwork/.env
echo "PASS_ID_$login=\"$PASS_ID\"" >> /server/passwork/.env