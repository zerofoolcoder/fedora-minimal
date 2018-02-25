#!/bin/bash

not_running=$(pidof cmus)

if [ -z "$not_running" ]; then
  echo ""
  exit
fi

artist=$(cmus-remote -Q | grep ' artist ' | cut -d ' ' -f3-)
if [ -z "$artist" ]; then
  exit
fi

album=$(cmus-remote -Q | grep ' album ' | cut -d ' ' -f3-)
title=$(cmus-remote -Q | grep ' title ' | cut -d ' ' -f3-)
echo -e "%{F#A1A1A1}\uE05C %{F#FFFFFF}$artist - $album - $title %{F#A1A1A1}\uE05C"


