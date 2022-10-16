#!/bin/bash
URL="$1"
RC_PORT=35605
STREAM_URL="$(streamlink --stream-url $URL best)"
TITLE="${URL##*/}"
echo "enqueue $STREAM_URL :meta-title=${TITLE}" | netcat localhost ${RC_PORT} -w 1
