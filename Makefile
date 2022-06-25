.DEFAULT_GOAL := run-media

run-media:
	@docker-compose up -d

stop-media:
	@docker-compose down -v

adguardhome:
	@cd adguardhome && docker-compose up -d

adguardhome-stop:
	@cd adguardhome && docker-compose down -v
