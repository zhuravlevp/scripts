#!/bin/bash
#Using script with shortcut & clipboard
#url="$(xclip -o -selection clipboard)"
url="$1"

TEST_SPEED_FILE=/tmp/play_yt_speedtest
# Use for set min bandwidth (KB/s)
TEST_SPEED_FILE_SIZE_LIMIT=1024 # 1MB
RC_PORT=35605
#Max resolution
RES="1080"
#RES="1440"
#RES="2160"

[ -z "$url" ] && exit 1
YOU_DL="$(which youtube-dl)"

func_get_data () {
# Set codec avc1 to use video without HDR
full_data="$($YOU_DL -e -g -f "bestvideo[height<=?$RES][ext=mp4][vcodec^=avc1]"+worstaudio[ext=m4a]/"best[height<=?$RES]" "$url")"

# For HDR
#full_data="$($YOU_DL -e -g -f "bestvideo[height<=?$RES][ext=mp4]"+worstaudio/"best[height<=?$RES]" "$url")"

#TITLE="$(sed -n 1p <<< $full_data)"
TITLE="$(sed -n 1p <<< $full_data|tr ' ' '_')"
URL_VIDEO="$(sed -n 2p <<< $full_data)"
URL_AUDIO="$(sed -n 3p <<< $full_data)"
}

while [[ -z "$CHECK_SPEED" ]]
do
func_get_data
(ulimit -S -f ${TEST_SPEED_FILE_SIZE_LIMIT}; timeout -s SIGINT 1 wget -q -O ${TEST_SPEED_FILE} "$URL_VIDEO") >/dev/null 2>&1
# Exit code 153: if wget killed ulimit
# Exit code 124: if wget killed timeout
[[ "$?" == "153" ]] && CHECK_SPEED=OK || echo "Check speed fail, retry... $URL_VIDEO"
done

#vlc -q -d "$URL_VIDEO" --input-slave "$URL_AUDIO" --meta-title "$TITLE" >/dev/null 2>&1

# Send command play video to rc interface vlc on port ${RC_PORT}
echo "add $URL_VIDEO :input-slave=$URL_AUDIO :meta-title=$TITLE" | netcat localhost ${RC_PORT} -w 1
