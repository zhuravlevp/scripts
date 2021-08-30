#!/bin/bash
#######################################################
#
#        File: mycommands.sh.dist
#
# this is an out of the box test and example file to show what's possible in mycommands.sh
#
# #### if you start to develop your own bot, use the clean version of this file:
# #### mycommands.clean
#
#       Usage: will be executed when a bot command is received 
#
#     License: WTFPLv2 http://www.wtfpl.net/txt/copying/
#      Author: KayM (gnadelwartz), kay@rrr.de
#
#### $$VERSION$$ v1.5-0-g8adca9b
#######################################################
# shellcheck disable=SC1117

####################
# Config has moved to bashbot.conf
# shellcheck source=./commands.sh
[ -r "${BASHBOT_ETC:-.}/mycommands.conf" ] && source "${BASHBOT_ETC:-.}/mycommands.conf"  "$1"


##################
# let's go ...
if [ "$1" = "startbot" ];then
    ###################
    # this section is processed on startup
    BOTADMIN="$(getConfigKey "botadmin")"

    # mark startup, triggers action on first message
    setConfigKey "startupaction" "await"
else

# Comands for admin
  if [[ "${USER[USERNAME]}" == "${BOTADMIN}" ]]
  then
    case "${MESSAGE}" in
      "https://www.youtube"*) ${SCRIPTS_DIR}/play_yt.sh "${MESSAGE}"; send_normal_message "${USER[ID]}" "Play video"  ;;
      "https://youtu.be"*) ${SCRIPTS_DIR}/play_yt.sh "${MESSAGE}";  send_normal_message "${USER[ID]}" "Play video" ;;
      "https://"*|"http://"*) send_normal_message "${USER[ID]}" "INVALID_URL ${MESSAGE}";;
      *) send_normal_message "${USER[ID]}" "???";;
    esac
  else
    send_normal_message "${CHAT[ID]}" "You are not admin"
  fi

fi
