#!/bin/bash
sleep 0.5
xdotool type "$(xclip -o -selection clipboard)"
