#!/bin/bash

USER_OAUTH_TOKEN=`cat user_oauth_token.txt`

count=0

curl -s -XPOST "https://slack.com/api/conversations.list" -H "Authorization: Bearer ${USER_OAUTH_TOKEN}" | \
  sed -r 's/[{]"ok":true,"channels":.//' | \
  sed -r 's/.,"response_metadata":.+/\n/' | \
  sed -r 's/},{/}\n{/g' | \
  sed -r 's/([{]"id":"|"name":|"is_channel":|,"is_group":.+)//g' | \
  sed -r 's/","?/ /' | while read line
do
  let count++
  f=(${line})
  echo \#${count} "{\"id\":\"${f[0]}\",\"name\":\"${f[1]}\",\"is_channel\":${f[2]}}"
  curl -s -XPOST "https://slack.com/api/conversations.join" \
    -H "Authorization: Bearer ${USER_OAUTH_TOKEN}" \
    -H "Content-Type: application/json; charset=utf-8" \
    -d "{\"channel\":\"${f[0]}\"}" | \
  sed -r 's/,\"channel\":.+/}/'
  echo
  sleep 1
done
