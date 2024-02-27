

up:
	docker compose up -d

add-data:
	docker compose exec postgresql bash /scripts/insert-data.sh

