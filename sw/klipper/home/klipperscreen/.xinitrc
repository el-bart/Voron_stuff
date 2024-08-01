#!/bin/bash
set -eux -o pipefail

# TODO: remove once perms are fixed
xhost +si:localuser:root
xhost +si:localuser:basz

# disable power saving, screen blanking, etc...
xset -dpms
xset s off
xset s noblank

# browser in a kiosk mode
exec matchbox-window-manager
