#!/bin/bash

# Launch this script to check if given room_code is valid or not (whether it exists or not)
# Notice that meeting rooms are global and any valid authorization parameters (regardless of account) are suitable
# Usage: ./check_meeting_space.sh SAPISIDHASH x-goog-api-key x-goog-authuser __Secure-3PSID __Secure-3PAPISID room_code
# Output: POST response HTTP status code
#   200 -> meeting space exists
#   404 -> meeting space doesn't exist
#   400 -> bad request, the code is not valid

# Parameter             Variable name
# SAPISIDHASH           sapisidhash
# x-goog-api-key        x_goog_api_key
# x-goog-authuser       x_goog_authuser
# __Secure-3PSID        secure_3psid
# __Secure-3PAPISID     secure_3papisid
# room_code             room_code

if [[ "$1" == "-h" ]] || [[ "$1" == "--help" ]]
then
    echo "Usage: ./check_meeting_space.sh SAPISIDHASH x-goog-api-key x-goog-authuser __Secure-3PSID __Secure-3PAPISID room_code"
    exit 0
fi

if (( "$#" != 6 ))
then
    echo "Illegal number of parameters"
    echo "See usage with -h option"
    exit 1
fi

sapisidhash="$1"
x_goog_api_key="$2"
x_goog_authuser="$3"
secure_3psid="$4"
secure_3papisid="$5"
room_code="$6"

curl 'https://meet.google.com/$rpc/google.rtc.meetings.v1.MeetingSpaceService/ResolveMeetingSpace' -H "authorization: SAPISIDHASH $sapisidhash" -H 'content-type: application/x-protobuf' -H "x-goog-api-key: $x_goog_api_key" -H "x-goog-authuser: $x_goog_authuser" -H 'x-goog-encode-response-if-executable: base64' -H 'Origin: https://meet.google.com' -H "Cookie: __Secure-3PSID=$secure_3psid; __Secure-3PAPISID=$secure_3papisid;" --data-raw "$(echo -en "\n\x0c"$room_code"0\x01")" -s -i \
| head -n 1 \
| grep -oP "HTTP/.+?\s\K\d+";
