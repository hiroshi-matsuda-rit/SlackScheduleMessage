#!/bin/bash

USER_OAUTH_TOKEN=`cat user_oauth_token.txt`

curl -s -XPOST "https://slack.com/api/chat.scheduledMessages.list" -H "Authorization: Bearer ${USER_OAUTH_TOKEN}" | \
  sed -r 's/[{]"ok":true,"scheduled_messages":.//' | \
  sed -r 's/.,"response_metadata":.+//' | \
  sed -r 's/},{/}\n{/g'
echo
