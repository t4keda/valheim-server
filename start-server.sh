#!/bin/bash
export temp_ldpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/home/steam/data/linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

cp /home/steam/data/linux64/steamclient.so /home/steam/data

export LD_LIBRARY_PATH=$temp_ldpath

if [ -z ${SERVER_PASSWORD} ] || [ ${#SERVER_PASSWORD} -lt 5 ]; then
    echo "The password must be at least 5 characters long!!!"
    exit 1
fi

echo ${params[@]}
echo "### Starting Valheim server ###"
exec ./data/valheim_server.x86_64 \
  -name "${SERVER_NAME}" \
  -port "${SERVER_PORT}" \
  -world "${SERVER_WORLD}" \
  -savedir "${SAVE_PATH}" \
  -password "${SERVER_PASSWORD}" \
  -public ${PUBLIC}
