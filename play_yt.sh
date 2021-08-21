#!/bin/bash
#Using script with shortcut & clipboard
#url="$(xclip -o -selection clipboard)"
url="$1"

#Max resolution
RES="1080"
#RES="1440"
#RES="2160"

[ -z "$url" ] && exit 1
YOU_DL="$(which youtube-dl)"

full_data="$($YOU_DL -e -g -f "bestvideo[height<=?$RES][ext=mp4][vcodec^=avc1]"+worstaudio/"best[height<=?$RES]" "$url")"
# If you use HDR 
#full_data="$($YOU_DL -e -g -f "bestvideo[height<=?$RES][ext=mp4]"+worstaudio/"best[height<=?$RES]" "$url")"

TITLE="$(sed -n 1p <<< $full_data)"
URL_VIDEO="$(sed -n 2p <<< $full_data)"
URL_AUDIO="$(sed -n 3p <<< $full_data)"

vlc -q -d "$URL_VIDEO" --input-slave "$URL_AUDIO" --meta-title "$TITLE"
