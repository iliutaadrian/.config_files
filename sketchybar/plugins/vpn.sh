#!/bin/bash

source "$CONFIG_DIR/colors.sh"

LABEL=""

if pgrep -fi openvpn >/dev/null 2>&1; then
  # Tunnelblick / OpenVPN — region from the .tblk filename, e.g. (frankfurt)
  L=$(pgrep -fil openvpn | grep -oE '\([a-zA-Z0-9_-]+\)' | head -1 | tr -d '()')
  LABEL="${L:-ovpn}"
elif pgrep -f WireGuardNetworkExtension >/dev/null 2>&1; then
  # WireGuard tunnel active (e.g. Proxmox); use the Connected WG config name if exposed
  WG=$(scutil --nc list 2>/dev/null | awk -F'"' '/Connected/ && /com\.wireguard/ {print $2; exit}')
  LABEL="${WG:-wg}"
fi

if [ -n "$LABEL" ]; then
  sketchybar --set "$NAME" icon=􀎡 icon.color=$ICON_COLOR label="$LABEL" label.color=$WHITE
else
  sketchybar --set "$NAME" icon=􀎢 icon.color=0xff8a8f98 label="off" label.color=0xff8a8f98
fi
