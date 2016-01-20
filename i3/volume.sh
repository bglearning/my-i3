#!/bin/bash

volume=""
state=$1
commad=""
text=""
notify="notify-send -t 200 -u low "

if [[ "$1" == "--toggle" ]]; then
    amixer -D pulse sset Master toggle
elif [[ "$1" == "--up" ]]; then
    amixer -D pulse sset Master 5%+
    volume=`awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master)`
    notify="$notify 'VOLUME UP' '$volume' "
else
    amixer -D pulse sset Master 5%-
    volume=`awk -F"[][]" '/dB/ { print $2 }' <(amixer sget Master)`
    notify="$notify 'VOLUME DOWN' '$volume' "
fi

eval $notify

