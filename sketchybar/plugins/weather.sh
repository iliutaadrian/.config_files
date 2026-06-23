#!/bin/bash

# Leave CITY empty to auto-detect by IP (follows VPN exit). Set e.g. "Bucharest" to pin.
CITY=""

RAW=$(curl -s --max-time 5 "https://wttr.in/${CITY}?format=%C|%l|%t" 2>/dev/null)

COND=$(echo "$RAW" | cut -d'|' -f1 | xargs | tr '[:upper:]' '[:lower:]')
LOC=$(echo "$RAW"  | cut -d'|' -f2 | cut -d',' -f1 | xargs | cut -c1-3)
TEMP=$(echo "$RAW" | cut -d'|' -f3 | tr -d '+' | xargs)

case "$COND" in
  *thunder*)                        ICON=􀇟 ;;
  *snow*|*sleet*|*blizzard*|*ice*)  ICON=􀇏 ;;
  *rain*|*drizzle*|*shower*)        ICON=􀇉 ;;
  *fog*|*mist*|*haze*)              ICON=􀇋 ;;
  *partly*)                         ICON=􀇕 ;;
  *overcast*|*cloud*)               ICON=􀇃 ;;
  *sun*|*clear*)                    ICON=􀆭 ;;
  *)                                ICON=􀇕 ;;
esac

if [ -n "$TEMP" ]; then
  sketchybar --set "$NAME" icon="$ICON" label="${LOC} ${TEMP}"
else
  sketchybar --set "$NAME" icon="$ICON"
fi
