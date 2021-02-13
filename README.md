# docker-valheim
Docker server for [Valheim](https://store.steampowered.com/app/892970/Valheim/) based on [https://github.com/nopor/docker-valheim](https://github.com/nopor/docker-valheim)

 Docker image available at [https://hub.docker.com/r/bonebroke/valheim-server](https://hub.docker.com/r/bonebroke/valheim-server)

## Instructions
Start the server with the following env vars:
- CPU_MHZ cpu frecuency in mhz (required by steamcmd)
- SERVER_NAME
- SERVER_PASSWORD
  - must be at least 5 characters long!
- SERVER_WORLD
- SAVE_PATH path to the savegame

There is an example docker-compose.yml file added that mounts ```./save``` directory on the save_path of the container to persist the world between container restarts
