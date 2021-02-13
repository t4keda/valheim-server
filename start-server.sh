export temp_ldpath=$LD_LIBRARY_PATH
export LD_LIBRARY_PATH=/home/steam/data/linux64:$LD_LIBRARY_PATH
export SteamAppId=892970

cp /home/steam/data/linux64/steamclient.so /home/steam/data

export LD_LIBRARY_PATH=$temp_ldpath

echo "### Starting Valheim server ###"
./data/valheim_server.x86_64 \
  -name ${SERVER_NAME} \
  -port ${SERVER_PORT} \
  -world ${SERVER_WORLD} \
  -password ${SERVER_PASSWORD} \
  -savedir ${SAVE_PATH} \
  -public 1
