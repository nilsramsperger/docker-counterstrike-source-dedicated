# Counterstrike Source dedicated server
This image provides a plain CS:S dedicated server.

## System Requirements
The server is not contained by the image, to keep it small.
It will download and install on first start of the container.
You will need at least **3GB** of HDD space, for the container to inflate.

## Usage
To start the container run `docker run -d --init --name css-dedicated --restart unless-stopped -v css-dedicated-config:/var/css/cfg -p 27015:27015 -p 27015:27015/udp -e RCON_PASSWORD=mypassword -e CSS_PASSWORD=mypassword -e CSS_HOSTNAME=myservername -e PORT=27015 nilsramsperger/counterstrike-source-dedicated`.

Change the ENV variables `RCON_PASSWORD`, `CSS_PASSWORD` and `CSS_HOSTNAME` as you like.

If you want it to use another port, change `-e PORT=27015` and `-p 27015:27015 -p 27015:27015/udp` accordingly.
Internal and external ports must match.

The server's config folder is persisted in the named volume `css-dedicated-config`.
So if you want to change settings, just tap into the container, change the files within config and restart.
The changes won't get lost.

## Integrated mods
* SourceMod 1.9.0
* MetaModSource 1.10.0
* DamageReport