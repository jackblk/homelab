# Homelab

My private homelab :).
## Jellyfin

```bash
# Create data folder
sudo mkdir /app
sudo chown -R $USER:$USER /app

# Run
cd jellyfin
docker-compose up -d
cd ..
```

## Qbittorrent-nox

```bash
cd qbit
docker-compose up -d
cd ..
```

## Cloudflared

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

## Hardware Acceleration

For VAAPI:

```bash
# for my intel igpu sandy bridge 2xxx
sudo apt install libva-dev i965-va-driver
```

Set supported codecs to decode with VAAPI by checking `vainfo`.
VA API device should be `/dev/dri/renderD128` or `/dev/dri/renderD129` based on your GPU.

For [newer Intel iGPU](https://jellyfin.org/docs/general/administration/hardware-acceleration.html#configuring-intel-quicksyncqsv-on-debianubuntu):

```bash
sudo apt install vainfo intel-media-va-driver-non-free
```

# Misc

* [DDClient to update DDNS](https://blog.jswart.xyz/posts/cloudflare-dynamic-dns/)
* [Jellyfin Let's Encrypt and Docker](https://jellyfin.org/docs/general/networking/letsencrypt.html#lets-encrypt-and-docker)
* [linuxserver/swag](https://docs.linuxserver.io/images/docker-swag#parameters)