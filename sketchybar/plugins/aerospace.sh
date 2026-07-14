#!/bin/bash

source "$CONFIG_DIR/colors.sh"
AERO="/opt/homebrew/bin/aerospace"
sid="$1"

# subtle transparent dark blue for the active workspace pill (tweak freely)
FOCUS_BG=0xaa16335c

FOCUSED="${FOCUSED_WORKSPACE:-$($AERO list-workspaces --focused 2>/dev/null)}"
apps=$($AERO list-windows --workspace "$sid" 2>/dev/null | awk -F'|' '{gsub(/^[ \t]+|[ \t]+$/,"",$2); print $2}' | sort -u)

strip=""
while IFS= read -r app; do
  [ -z "$app" ] && continue
  strip+="$("$CONFIG_DIR/plugins/icon_map_fn.sh" "$app") "
done <<< "$apps"
strip="${strip% }"

PILL="background.drawing=on background.corner_radius=9 background.height=28 background.border_width=1 background.border_color=0x26ffffff"

if [ -z "$apps" ] && [ "$sid" != "$FOCUSED" ]; then
  sketchybar --set "$NAME" drawing=off
elif [ "$sid" = "$FOCUSED" ]; then
  sketchybar --set "$NAME" drawing=on $PILL background.color=$FOCUS_BG icon.color=$WHITE label="$strip" label.color=$WHITE
else
  sketchybar --set "$NAME" drawing=on $PILL background.color=0x59000000 icon.color=$ICON_COLOR label="$strip" label.color=$ICON_COLOR
fi
