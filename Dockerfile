FROM steamcmd/steamcmd:alpine-3

# hadolint ignore=DL3008
RUN set -x \
 && apk update \
 && akp add gosu xdg-user-dirs --no-interactive --no-cache\
 && useradd -ms /bin/bash steam \
 && gosu nobody true

RUN mkdir -p /config \
 && chown steam:steam /config

COPY init.sh /
COPY --chown=steam:steam *.ini run.sh /home/steam/

WORKDIR /config

ENV DEBUG="false" \
    DISABLESEASONALEVENTS="false" \
    GAMECONFIGDIR="/config/gamefiles/FactoryGame/Saved" \
    GAMESAVESDIR="/home/steam/.config/Epic/FactoryGame/Saved/SaveGames" \
    MAXOBJECTS="2162688" \
    MAXPLAYERS="4" \
    MAXTICKRATE="30" \
    PGID="1000" \
    PUID="1000" \
    ROOTLESS="false" \
    SERVERGAMEPORT="7777" \
    SERVERSTREAMING="true" \
    SKIPUPDATE="false" \
    STEAMAPPID="1690800" \
    STEAMBETA="false" \
    TIMEOUT="30"

EXPOSE 7777/udp 7777/tcp

ENTRYPOINT [ "/init.sh" ]
