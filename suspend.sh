#!/bin/sh
# /usr/lib/systemd/system-sleep/
case $1 in
  post)
    sleep 2
    /home/pz/relay/bin-Linux-x64/hidusb-relay-cmd on 1
#    mount -a > /tmp/sus 2>&1 && echo ok_up >> /tmp/sus
    rm -f /home/pz/scripts/suspend.sh.lock
    ;;
  pre)
#    sleep 2
    /home/pz/relay/bin-Linux-x64/hidusb-relay-cmd off 1
    sleep 2
#    umount -a -f -t cifs > /tmp/sus 2>&1 && echo ok_down >> /tmp/sus
    touch /home/pz/scripts/suspend.sh.lock
    ;;
esac
