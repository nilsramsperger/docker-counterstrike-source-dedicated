# Counterstrike Source dedicated server
This image provides a plain CS:S dedicated server.

## Usage
To start the container run `docker run -d --init --name css-dedicated --restart unless-stopped -v css-dedicated-config:/opt/steam/css/cstrike/cfg -p 27015:27015 -p 27015:27015/udp -p 1200:1200 -p 27005:27005/udp -p 27020:27020/udp -p 26901:26901/udp -e RCON_PASSWORD=mypassword -e CSS_PASSWORD=mypassword -e CSS_HOSTNAME=myservername nilsramsperger/counterstrike-source-dedicated`.
Change the ENV variables `RCON_PASSWORD`, `CSS_PASSWORD` and `CSS_HOSTNAME` as you like.

The server's config folder is persisted in the named volume `css-dedicated-config`.
So if you want to change settings, just tap into the container, change the files within config and restart.
The changes won't get lost.

## Credits
Thanks to _foxylion_ (https://hub.docker.com/r/foxylion/steam-css/) for the inspiration to build this image.