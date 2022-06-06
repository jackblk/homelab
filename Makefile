.DEFAULT_GOAL := run-media

run-media:
	@docker-compose up -d

stop-media:
	@docker-compose down -v