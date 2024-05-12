.DEFAULT_GOAL := run-media

run-media:
	@docker-compose up -d
	@docker exec -u root -it jellyfin chown 1000 /jellyfin/jellyfin-web/index.html

stop-media:
	@docker-compose down -v

dns-adguardhome:
	@cd adguardhome && docker-compose up -d

dns-adguardhome-stop:
	@cd adguardhome && docker-compose down -v
