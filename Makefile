.DEFAULT_GOAL := run-media

run-media:
	@cd jellyfin && docker-compose up -d

stop-media:
	@cd jellyfin && docker-compose down -v