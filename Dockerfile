FROM cm2network/steamcmd:latest

USER root
RUN apt-get update && \
	apt-get -y install --no-install-recommends libsdl2-2.0-0 && \
	rm -rf /var/lib/apt/lists/*

WORKDIR /home/steam

ADD entrypoint.sh /home/steam/entrypoint.sh
ADD start-server.sh /home/steam/start-server.sh

RUN mkdir -p /home/steam/scripts/ && ulimit -n 2048 && \
	chown steam:users /home/steam/entrypoint.sh && \
	chown steam:users /home/steam/start-server.sh && \
	chmod +x /home/steam/entrypoint.sh && \
	chmod +x /home/steam/start-server.sh && \
	mkdir -p /home/steam/save && chown steam:users /home/steam/save

USER steam

EXPOSE 2456/udp
EXPOSE 2456/tcp
EXPOSE 2457/udp
EXPOSE 2457/tcp
EXPOSE 2458/udp
EXPOSE 2458/tcp

ENV SERVER_NAME="Valheim Server"
ENV SERVER_PASSWORD=""
ENV SERVER_WORLD="World"
ENV SERVER_PORT=2456
ENV SAVE_PATH="/home/steam/save"
ENV public=1
ENV BETA_NAME=""
ENV BETA_PASSWORD=""

STOPSIGNAL SIGINT

ENTRYPOINT ["/bin/bash", "entrypoint.sh"]

CMD ["./start-server.sh", "-n"]
