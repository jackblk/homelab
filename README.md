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
* Route DNS for Jelly: `cloudflared tunnel route dns homelab flix`
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

# Misc

* [DDClient to update DDNS](https://blog.jswart.xyz/posts/cloudflare-dynamic-dns/)