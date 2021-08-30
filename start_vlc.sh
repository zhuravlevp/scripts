#!/bin/bash
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
#( [[ -f "${SCRIPT_DIR}/.env" ]] && source ${SCRIPT_DIR}/.env ) || ( echo "File .env not exist" && exit 1 )
[[ -f "${SCRIPT_DIR}/.env" ]] && source ${SCRIPT_DIR}/.env || exit 1
VLC_QT_PARAMS="--qt-continue 0 --qt-minimal-view  --no-qt-bgcone"
# Run from ssh, systemd ...
#export DYSPLAY=":0"
[[ "${VLC_VERBOSE}" == "none" ]] && VLC_VERBOSE="0 -q"
${VLC} --avcodec-hw vaapi --verbose ${VLC_VERBOSE} --intf qt ${VLC_QT_PARAMS} --extraintf rc:http --rc-host=${RC_HOST} --http-host=${HTTP_HOST} --http-password=${HTTP_PASSWOD}
