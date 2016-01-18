#!/bin/bash

command=$(upower -i $(upower -e | grep BAT) | grep --color=never -E "state|to\ full|to\ empty|percentage")

res=$(echo $command)

# get state
state=$(echo $res | awk '{ print $2 }')

# get %
percentage=$(echo $res | awk '{ print $9 }')
percentage=${percentage:0:2}

# get time
t=$(echo $res | awk '{ print $6 $7}')

full_text="$percentage%"

color=""

if [[ $state == "charging" ]]; then
    full_text="$full_text CHR"
else
    full_text="$full_text DIS"
fi

if [[ "$t" =~ [0-9]*\.[0-9]*hours ]]; then
    full_text="$full_text ${t:0:3}hr"
else
    full_text="$full_text ${t:0:3}min"
fi

if [[ "$percentage" -lt 20 ]]; then
    color="$color#FF0000"
elif [[ "$percentage" -lt 40 ]]; then
    color="$color#FFAE00"
elif [[ "$percentage" -lt 60 ]]; then
    color="$color#FF6000"
elif [[ "$percentage" -lt 85 ]]; then
    color="$color#A8FF00"
else
    color="$color#FFFFFF"
fi


echo "$full_text"
echo
echo $color
