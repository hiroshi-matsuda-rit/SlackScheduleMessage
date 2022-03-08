#!/bin/bash

USER_OAUTH_TOKEN=`cat user_oauth_token.txt`

count=0

while read line
do
  let count++
  echo \#${count} ${line}
  curl -s -XPOST "https://slack.com/api/chat.scheduleMessage" \
    -H "Authorization: Bearer ${USER_OAUTH_TOKEN}" \
    -H "Content-Type: application/json; charset=utf-8" \
    -d "${line}" | \
  sed -r 's/,"message":.+/}/'
  echo
  sleep 1
done
