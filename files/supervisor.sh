#!/usr/bin/env bash

shutdown() {
    kill ${!}
    echo "Stopped"
    exit 143;
}

term_handler() {
    echo "SIGTERM received"
    shutdown
}

trap term_handler SIGTERM
cd /opt/steam/css
./srcds_run -game cstrike +exec server.cfg +hostname ${CSS_HOSTNAME} +sv_password ${CSS_PASSWORD} +rcon_password ${RCON_PASSWORD} +map de_dust2 & wait ${!}
echo "CS:S dedicated died"
shutdown