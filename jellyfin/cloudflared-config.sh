#!/bin/bash
export TUNNELID=cloudflared tunnel list | grep 'homelab' | awk '{print $1;}'
envsubst <template.yml >/etc/cloudflared/config.yml
