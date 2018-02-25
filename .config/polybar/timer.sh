#!/bin/bash

week=$(timew summary :week | awk '/(^\s+)[0-9]/ {printf "%s", $NF}')
day=$(timew summary :day | awk '/(^\s+)[0-9]/ {printf "%s", $NF}')

estimated_minutes=$(timew summary :week | awk '/(^\s+)[0-9]/ {printf "%s", $NF}' | awk -F: '{print $1*60+$2}')
if [ -z "$estimated_minutes" ]; then
  exit
fi

if [[ $(date +%u) > 5 ]]; then
  working_days=5
else
  working_days=$(date +%u)
fi

real_minutes=$(( $working_days * 8 * 60))
pct=$(echo $estimated_minutes / $real_minutes | bc -l)

if [[ $( echo "$pct < 0.25" | bc ) -eq 1 ]]; then
  icon="%{F#FDFF00}\uE00F%{F#EA82E5}\uE0AA%{F#46BFEE}\uE0C6%{F#D03E19}\uE0C7%{F#DB851C}\uE0C8"
fi

if [[ $( echo "$pct >= 0.25" | bc ) -eq 1 && $( echo "$pct < 0.50" | bc ) -eq 1 ]]; then
  icon="%{F#EA82E5}\uE140%{F#FDFF00}\uE00F%{F#46BFEE}\uE0C6%{F#D03E19}\uE0C7%{F#DB851C}\uE0C8"
fi

if [[ $( echo "$pct >= 0.5" | bc ) -eq 1 && $( echo "$pct < 0.75" | bc ) -eq 1 ]]; then
  icon="%{F#EA82E5}\uE140%{F#46BFEE}\uE141%{F#FDFF00}\uE00F%{F#D03E19}\uE0C7%{F#DB851C}\uE0C8"
fi

if [[ $( echo "$pct >= 0.75" | bc ) -eq 1 && $( echo "$pct < 1.0" | bc ) -eq 1 ]]; then
  icon="%{F#EA82E5}\uE140%{F#46BFEE}\uE141%{F#D03E19}\uE143%{F#FDFF00}\uE00F%{F#DB851C}\uE0C8"
fi

if [[ $( echo "$pct >= 1.0" | bc ) -eq 1 ]]; then
  icon="%{F#EA82E5}\uE140%{F#46BFEE}\uE141%{F#D03E19}\uE143%{F#DB851C}\uE142%{F#FDFF00}\uE00F"
fi

echo -e "%{F#A1A1A1}\uE225%{F#FFFFFF}$week %{F#A1A1A1}\uE004%{F#FFFFFF}$day $icon"
