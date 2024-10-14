#!/usr/bin/env bash

set -e

# needs pve-manager >= 3.1-44

# Predefined variables
PASSWORD="wanted"               # Password for the user
USERNAME="root@pam"             # Username with realm
PROXY="192.168.100.63"          # Proxy server (replace with your actual IP or hostname)
NODE="z440prox"                 # Node name (replace with your actual node name)

# Check if VM ID is provided as an argument
if [ -z "$1" ]; then
  echo "Usage: $0 <vmid>"
  exit 1
fi

VMID="$1"  # The VM ID passed as an argument

# Authenticate with the Proxmox API to get a ticket
DATA="$(curl -f -s -S -k --data-urlencode "username=$USERNAME" --data-urlencode "password=$PASSWORD" "https://$PROXY:8006/api2/json/access/ticket")"

# Extract the ticket and CSRF token from the response
echo "AUTH OK"

TICKET="${DATA//\"/}"
TICKET="${TICKET##*ticket:}"
TICKET="${TICKET%%,*}"
TICKET="${TICKET%%\}*}"

CSRF="${DATA//\"/}"
CSRF="${CSRF##*CSRFPreventionToken:}"
CSRF="${CSRF%%,*}"
CSRF="${CSRF%%\}*}"

# Request the SPICE configuration for the specified VM
curl -f -s -S -k -b "PVEAuthCookie=$TICKET" -H "CSRFPreventionToken: $CSRF" "https://$PROXY:8006/api2/spiceconfig/nodes/$NODE/qemu/$VMID/spiceproxy" -d "proxy=$PROXY" > $NODE-$VMID.vv

# Open the SPICE session using remote-viewer
exec remote-viewer $NODE-$VMID.vv
