FROM steamcmd/steamcmd:alpine-3

# hadolint ignore=DL3008
RUN set -x
RUN apk update
RUN apk add xdg-user-dirs curl jq --no-interactive --no-cache
RUN adduser -Ds /bin/bash steam

RUN mkdir -p /config \
 && chown steam:steam /config

COPY init.sh healthcheck.sh /
COPY --chown=steam:steam run.sh /home/steam/

WORKDIR /config

ARG VERSION="DEV"
ENV VERSION=$VERSION
LABEL version=$VERSION

ENV AUTOSAVENUM="5" \
    DEBUG="false" \
    DISABLESEASONALEVENTS="false" \
    GAMECONFIGDIR="/config/gamefiles/FactoryGame/Saved" \
    GAMESAVESDIR="/home/steam/.config/Epic/FactoryGame/Saved/SaveGames" \
    LOG="false" \
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
    TIMEOUT="30" \
    VMOVERRIDE="false"

STOPSIGNAL SIGINT

EXPOSE 7777/udp 7777/tcp

ENTRYPOINT [ "/init.sh" ]
