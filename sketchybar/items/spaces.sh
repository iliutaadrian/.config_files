#!/bin/bash

AERO="/opt/homebrew/bin/aerospace"
sketchybar --add event aerospace_workspace_change

WORKSPACES="1 2 3 4 5 6 7 8 9 B E M N P T V"
for sid in $WORKSPACES; do
  sketchybar --add item space.$sid left \
    --subscribe space.$sid aerospace_workspace_change \
    --set space.$sid \
        icon="$sid" \
        icon.font="SF Pro:Bold:11.0" \
        icon.padding_left=8 \
        icon.padding_right=2 \
        label.font="sketchybar-app-font:Regular:14.0" \
        label.padding_left=4 \
        label.padding_right=9 \
        background.corner_radius=6 \
        background.height=26 \
        background.drawing=off \
        update_freq=10 \
        click_script="$AERO workspace $sid" \
        script="$PLUGIN_DIR/aerospace.sh $sid"
done
