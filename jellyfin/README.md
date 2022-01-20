## Cloudflared

### Install

This is not supported in `bullseye` yet. Refer: https://pkg.cloudflare.com/

```bash
RELEASE=bullseye
echo "deb [signed-by=/usr/share/keyrings/cloudflare-main.gpg] https://pkg.cloudflare.com/ $RELEASE main" | sudo tee /etc/apt/sources.list.d/cloudflare-main.list

# import key
sudo curl https://pkg.cloudflare.com/cloudflare-main.gpg -o /usr/share/keyrings/cloudflare-main.gpg

sudo apt-get update
sudo apt-get install cloudflared
```

Install via dpkg:
```bash
wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
sudo dpkg -i cloudflared-linux-amd64.deb
```

### Config

* Login: `cloudflared tunnel login`
* Create tunnel: `cloudflared tunnel create homelab`

Create config file:

```bash
sudo ./cloudflared-config.sh
sudo cloudflared service install
sudo systemctl enable cloudflared
```

### Usage

```bash
sudo systemctl start cloudflared
sudo systemctl status cloudflared
sudo systemctl stop cloudflared
```

### Fix folder permission issue

```bash
sudo chown -R user:usergroup /app
```