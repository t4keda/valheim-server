#!/bin/bash

function graceful_shutdown {
	echo "entrypoint"
	pid_line=$(ls -l /proc/*/exe|grep valheim_server)
	echo $pid_line
    a=${pid_line/*\/proc\//}
	echo $a
    pid=${a/\/*/}
	echo $pid
	kill -2 $pid

	while [ "$(ls -l /proc/*/exe|grep valheim_server|wc -l)" -ne "0" ]; do
	        # echo "wait for $valheim_container to stop..."
	        sleep 1
	done
}

trap graceful_shutdown SIGINT SIGTERM

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


echo "### Downloading Valheim Server ###"
/home/steam/steamcmd/steamcmd.sh +login anonymous +force_install_dir /home/steam/data "+app_update 896660 $beta_str" validate +quit

exec "$@"&
wait
