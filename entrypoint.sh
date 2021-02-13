#!/bin/bash
# Downloading/updating server on startup

echo "### Downloading Valheim Server ###"
/home/steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/steam/data +app_update 896660 validate +quit

exec "$@"
