#!/bin/bash
TUNNELID=$(cloudflared tunnel list | grep 'homelab' | awk '{print $1;}')
envsubst <template-cloudflared.yml | sudo tee /etc/cloudflared/config.yml >/dev/null
