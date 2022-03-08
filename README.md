# SlackScheduleMessage
Utility for calling chat.scheduleMessage API of Slack

## Set up

### Create a slack app and generate your User OAuth Token
Create your Slack app and generate your User OAuth Token with the User Token Scopes below:
- channels:read
- channels:write
- chat:write

https://api.slack.com/apps

Then, put the token to `user_oatuh_token.txt`.

### Add user to all the channels in your workspace
```console
add_user_to_all_channels.sh
```

### Prepare scheduled message list
Please see the example in `test.jsonl`.

### Let's post scheduled messages
```console
post_scheduled_messages.sh < test.jsonl
```

### You can view all scheduled messages
```console
show_scheduled_messages.sh
```

### You will probably have to delete all scheduled messages
```console
delete_all_scheduled_messages.sh
```

