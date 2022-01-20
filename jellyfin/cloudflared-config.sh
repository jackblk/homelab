#!/bin/bash
TUNNELID=$(cloudflared tunnel list | grep 'homelab' | awk '{print $1;}')
envsubst <template.yml | sudo tee /etc/cloudflared/config.yml >/dev/null
