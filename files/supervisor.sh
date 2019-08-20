#!/usr/bin/env bash

loadConfig() {
    echo "Loading config"
    yes | cp -rfa /var/css/cfg/. /opt/steam/css/cfg/
}

storeConfig() {
    echo "Storing config"
    yes | cp -rfa /opt/steam/css/cfg/. /var/css/cfg/
}

shutdown() {
    pkill srcds_linux
    storeConfig
    echo "Container stopped"
    exit 143;
}

term_handler() {
    echo "SIGTERM received"
    shutdown
}

install() {
    echo "Installing CS:S Dedicated Server"
    /opt/steam/steamcmd.sh +login anonymous +force_install_dir /opt/steam/css/ +app_update 232330 validate +quit
    chown -R steam:steam /opt/steam/css
    mv /tmp/cfg /opt/steam/css/cstrike/cfg
    mv /tmp/gem_damage_report.smx addons/sourcemod/plugins
    cd /opt/steam/css/cstrike
    tar zxvf /tmp/mmsource-1.10.7-git970-linux.tar.gz
    tar zxvf /tmp/sourcemod-1.9.0-git6281-linux.tar.gz 
    echo "Installation done"
}

update() {
    echo "Updating CS:S Dedicated Server"
    /opt/steam/steamcmd.sh +login anonymous +app_update 232330 +quit
    echo "Update done"
}

trap term_handler SIGTERM
[ ! -d "/opt/steam/css" ] && install || update
loadConfig
echo "Starting CS:S Dedicated Server"
cd /opt/steam/css
su steam -c "./srcds_run -game cstrike +exec server.cfg +hostname $CSS_HOSTNAME +sv_password $CSS_PASSWORD +rcon_password $RCON_PASSWORD +map de_dust2" & wait ${!}
echo "CS:S dedicated died"
shutdown