#!/bin/bash
STATUS=$( echo "status" | netcat localhost 35605 -w 1 | grep state | awk '{print $3}')
if [ "$STATUS" == "playing" ]
then
echo "pause" | netcat localhost 35605 -w 1
fi
#/home/pz/relay/bin-Linux-x64/hidusb-relay-cmd off 1
#sleep 2
systemctl suspend
