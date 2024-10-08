.DEFAULT_GOAL := run-media

run-media:
	@docker-compose up -d
	@docker exec -u root -it jellyfin chown 1000 /jellyfin/jellyfin-web/index.html
	@docker cp jellyfin:/jellyfin/jellyfin-web/main.jellyfin.bundle.js /datadisk/server/tmp/main.jellyfin.bundle.js
	@sed -E -i 's/enableBackdrops\:function\(\)\{return L\}/enableBackdrops\:function\(\)\{return \_\}/' /datadisk/server/tmp/main.jellyfin.bundle.js
	@docker cp /datadisk/server/tmp/main.jellyfin.bundle.js jellyfin:/jellyfin/jellyfin-web/main.jellyfin.bundle.js
	@rm /datadisk/server/tmp/main.jellyfin.bundle.js

stop-media:
	@docker-compose down -v

dns-adguardhome:
	@cd adguardhome && docker-compose up -d

dns-adguardhome-stop:
	@cd adguardhome && docker-compose down -v
