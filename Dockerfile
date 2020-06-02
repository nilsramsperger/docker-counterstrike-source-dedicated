FROM ubuntu:19.10
ADD ./files/supervisor.sh /
RUN apt-get update \
    && apt-get install -y wget lib32gcc1 lib32stdc++6 libcurl4 unzip locales \
    && wget -O /tmp/steamcmd_linux.tar.gz http://media.steampowered.com/installer/steamcmd_linux.tar.gz \
    && mkdir -p /opt/steam \
    && mkdir -p /var/css/cfg \
    && tar -C /opt/steam -xvzf /tmp/steamcmd_linux.tar.gz \
    && rm /tmp/steamcmd_linux.tar.gz \
    && chmod +x /supervisor.sh \
    && apt-get remove -y unzip wget \
    && useradd -ms /bin/bash steam \
    && mkdir -p /home/steam/.steam \
    && chown -R steam:steam /home/steam \
    && locale-gen en_US.UTF-8
ADD ./files/ /tmp
ENV CSS_HOSTNAME Counter-Strike Source Dedicated Server
ENV CSS_PASSWORD ""
ENV RCON_PASSWORD somepassword
VOLUME ["/var/css/cfg"]
CMD ["/supervisor.sh"]