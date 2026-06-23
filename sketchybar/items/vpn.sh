#!/bin/bash

sketchybar --add item vpn right \
           --set vpn update_freq=10 \
                     script="$PLUGIN_DIR/vpn.sh"
