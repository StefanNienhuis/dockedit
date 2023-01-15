#!/bin/bash

export PATH=/openvscode-server/bin:$PATH

# Set up user
PUID=${PUID:=1000}
PGID=${PGID:=1000}

groupadd -g $PGID group
useradd -ms /bin/bash -u $PUID -g $PGID user
cd /home/user

setpriv --reuid=$PUID --regid=$PGID --init-groups -- env HOME=/home/user $@