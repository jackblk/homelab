.DEFAULT_GOAL := run-media

run-media:
	@docker-compose up -d
	@docker exec -u root jellyfin chown 1000 /jellyfin/jellyfin-web/index.html
	@docker cp jellyfin:/jellyfin/jellyfin-web/main.jellyfin.bundle.js /data2/server/tmp/main.jellyfin.bundle.js

	@sed -E -i 's/enableBackdrops\:function\(\)\{return L\}/enableBackdrops\:function\(\)\{return \_\}/' /data2/server/tmp/main.jellyfin.bundle.js
	@docker cp /data2/server/tmp/main.jellyfin.bundle.js jellyfin:/jellyfin/jellyfin-web/main.jellyfin.bundle.js
	@rm /data2/server/tmp/main.jellyfin.bundle.js

	@docker exec -u root jellyfin cp /config/config.json /jellyfin/jellyfin-web/config.json
stop-media:
	@docker-compose down -v

dns-adguardhome:
	@cd adguardhome && docker-compose up -d

dns-adguardhome-stop:
	@cd adguardhome && docker-compose down -v
