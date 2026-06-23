#!/bin/bash

# Used RAM % = 100 - "System-wide memory free percentage"
FREE=$(memory_pressure 2>/dev/null | awk -F': ' '/percentage/ {gsub(/%/,"",$2); print $2}')
[ -z "$FREE" ] && exit 0
USED=$((100 - FREE))

sketchybar --set "$NAME" label="${USED}%"
