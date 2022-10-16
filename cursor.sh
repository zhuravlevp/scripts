#!/bin/bash
#set -x
func_get_proc ()
{
#ps -C unclutter -o pid=
ps -C unclutter -o pid= | wc -l
}
if [[ "$(func_get_proc)" -gt "0" ]]
then
  killall -q unclutter
else
  export DISPLAY=":0"
  unclutter -root -idle 0 &
fi
