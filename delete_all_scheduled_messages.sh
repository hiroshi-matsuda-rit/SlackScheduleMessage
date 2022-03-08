#!/bin/bash

USER_OAUTH_TOKEN=`cat user_oauth_token.txt`

count=0

./show_scheduled_messages.sh | \
  sed -r 's/([{]"id":"|"channel_id":|","post_at".+)//g' | \
  sed -r 's/","/ /' | while read line
do
  let count++
  f=(${line})
  echo \#${count} "{\"channel\":\"${f[1]}\",\"scheduled_message_id\":\"${f[0]}\"}"
  curl -s -XPOST "https://slack.com/api/chat.deleteScheduledMessage" \
    -H "Authorization: Bearer ${USER_OAUTH_TOKEN}" \
    -H "Content-Type: application/json; charset=utf-8" \
    -d "{\"channel\":\"${f[1]}\",\"scheduled_message_id\":\"${f[0]}\"}"
  echo
  sleep 1
done
