#!/bin/bash
set -eux -o pipefail

# disable power saving, screen blanking, etc...
xset -dpms
xset s off
xset s noblank

# browser in a kiosk mode
exec matchbox-window-manager
