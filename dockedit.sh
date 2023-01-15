#!/bin/bash

# Configuration
HOST=192.168.1.10
PORT=8080

if [ "$#" == 1 ]; then
    # Aliases
    case "$1" in
        "mqtt") VOLUME="mqtt"; PUID=1883; PGID=1883 ;;
        *) echo "Unknown alias $1"; exit ;;
    esac
elif [ "$#" == 2 ]; then
    VOLUME=$1; PUID=$2; PGID=$2
elif [ "$#" == 3 ]; then
    VOLUME=$1; PUID=$2; PGID=$3
else
    echo "Invalid parameters"
    exit 1
fi

CONNECTION_TOKEN=$(openssl rand -hex 16)

echo "Editor available at http://$HOST:$PORT/?tkn=$CONNECTION_TOKEN&folder=/$VOLUME"

# Open after 1 second
(sleep 1 && open "http://$HOST:$PORT/?tkn=$CONNECTION_TOKEN&folder=/$VOLUME" &)

# If something is not working, remove the > /dev/null at the end to debug
docker run --rm -it --name dockedit -p $PORT:$PORT -v $VOLUME:/$VOLUME -e PUID=$PUID -e PGID=$PGID stefannienhuis/dockedit openvscode-server --host 0.0.0.0 --port $PORT --connection-token $CONNECTION_TOKEN > /dev/null