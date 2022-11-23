#!/bin/bash
# Downloading/updating server on startup

beta_str=""
if [ ! -z "$BETA_NAME" ];then
	beta_str="-beta $BETA_NAME"
fi
if [ ! -z "$BETA_PASSWORD" ];then
	if [ ! -z "$beta_str" ];then
		beta_str="$beta_str "
	fi
	beta_str="$beta_str-betapassword $BETA_PASSWORD"
fi

printenv
echo "BETA $beta_str"

echo "### Downloading Valheim Server ###"
/home/steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/steam/data "+app_update 896660 $beta_str" validate +quit

exec "$@"
