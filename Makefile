

up:
	docker compose up -d

init: 
	docker compose exec postgresql bash /scripts/create-tables.sh

data:
	docker compose exec postgresql bash /scripts/insert-data.sh

