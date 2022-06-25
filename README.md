# Homelab

My private homelab :).
## Media server

```bash
# Create data folder
sudo mkdir /datadisk/server
sudo chown -R $USER:$USER /datadisk/server

# Clone repo
cd /datadisk/server
git clone https://github.com/jackblk/homelab.git
cd /datadisk/server/homelab

# Run
make

# Stop
make stop-media
```

Then:

* Configure Radarr, Sonarr, and Bazarr, Jackett, qBitTorrent and Jellyfin to use the media server.
* Configure hardware acceleration for Jellyfin.
* Configure Nginx proxy manager, DDClient for domains, DNS stuff.
* Configure heimdall for dashboard.


## Hardware Acceleration

For VAAPI:

```bash
# for my intel igpu sandy bridge 2xxx
sudo apt install libva-dev i965-va-driver
```

Set supported codecs to decode with VAAPI by checking `vainfo`.
VA API device should be `/dev/dri/renderD128` or `/dev/dri/renderD129` based on your GPU.

For [newer Intel iGPU](https://jellyfin.org/docs/general/administration/hardware-acceleration.html#va-api-hardware-acceleration-on-debianubuntu):

```bash
sudo apt install software-properties-common -y
sudo apt-add-repository non-free -y
sudo apt-get update
sudo apt install vainfo intel-media-va-driver-non-free
```

## Adguard Home


```shell
# run
make dns-adguardhome

# stop
make dns-adguardhome-stop
```

# Misc

* [DDClient to update DDNS](https://blog.jswart.xyz/posts/cloudflare-dynamic-dns/)
* [Jellyfin Let's Encrypt and Docker](https://jellyfin.org/docs/general/networking/letsencrypt.html#lets-encrypt-and-docker)
* [linuxserver/swag](https://docs.linuxserver.io/images/docker-swag#parameters)

## Folder structure

On host:

```
media -> for sonarr, radarr
├── torrents -> for qbit
│  ├── movies
│  └── shows
└── media -> for jellyfin
    ├── movies
    └── shows
```

On container:

```
data
├── torrents
│  ├── movies
│  ├── music
│  └── tv
└── media
   ├── movies
   ├── music
   └── tv
```

## Cloudflared

<details>
<summary>Not used</summary>

### Install

This is not supported in `bullseye` yet. Refer: https://pkg.cloudflare.com/

```bash
RELEASE=bullseye
echo "deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/ $RELEASE main" | sudo tee /etc/apt/sources.list.d/cloudflare-main.list

# import key
sudo curl https://pkg.cloudflare.com/cloudflare-main.gpg -o /usr/share/keyrings/cloudflare-main.gpg

sudo apt-get update
sudo apt-get install -y cloudflared
```

Install via dpkg:
```bash
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
sudo dpkg -i cloudflared-linux-amd64.deb
```

### Config

* Login: `cloudflared tunnel login`
* Create tunnel: `cloudflared tunnel create homelab`
* Route DNS for Qbit: `cloudflared tunnel route dns homelab tor`

Create config file:

```bash
bash cloudflared-config.sh # dont run by root
sudo cloudflared service install
sudo systemctl enable cloudflared
```

### Usage

```bash
sudo systemctl stop cloudflared
sudo systemctl start cloudflared
sudo systemctl status cloudflared
```

</details>