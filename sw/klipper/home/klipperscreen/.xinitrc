#!/bin/bash
set -eux -o pipefail

# disable power saving, screen blanking, etc...
xset -dpms
xset s off
xset s noblank

# hide mouse pointer
unclutter &

# browser in a kiosk mode
exec matchbox-window-manager
