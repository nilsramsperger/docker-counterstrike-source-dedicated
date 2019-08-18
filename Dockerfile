FROM ubuntu:latest
ADD ./files/supervisor.sh /
RUN apt-get update \
    && apt-get install -y wget lib32gcc1 lib32tinfo5 unzip \
    && wget -O /tmp/steamcmd_linux.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz \
    && mkdir -p /opt/steam \
    && tar -C /opt/steam -xvzf /tmp/steamcmd_linux.tar.gz \
    && rm /tmp/steamcmd_linux.tar.gz \
    && mkdir -p /opt/steam/css \
    && chmod +x /supervisor.sh \
    && apt-get remove -y unzip \
    && useradd -ms /bin/bash steam
ADD ./files/cfg/ /tmp
ENV CSS_HOSTNAME Counter-Strike Source Dedicated Server
ENV CSS_PASSWORD ""
ENV RCON_PASSWORD somepassword
VOLUME ["/var/css/cfg"]
USER steam
CMD ["/supervisor.sh"]