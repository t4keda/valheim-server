# docker-valheim
Docker server for [Valheim](https://store.steampowered.com/app/892970/Valheim/) based on [https://github.com/nopor/docker-valheim](https://github.com/nopor/docker-valheim)

 Docker image available at [https://hub.docker.com/r/bonebroke/valheim-server](https://hub.docker.com/r/bonebroke/valheim-server)

## Instructions
configure env.conf file with the values you want and launch the server using the example docker-compose
Launch the docker-compose.yml 
env vars can be configured:
- CPU_MHZ cpu frecuency in mhz (required by steamcmd)
- SERVER_NAME
- SERVER_PASSWORD
  - must be at least 5 characters long!
- SERVER_WORLD
- SAVE_PATH path to the savegame
- PUBLIC if set to 1 the server will be listed in the server browser

The provided docker-compose.yml example file mounts ```./save``` directory on the save_path of the container to persist the world between container restarts
