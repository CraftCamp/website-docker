install: build up status

prod-install: prod-up prod-status

prod-upgrade:

	docker pull craftcamp/website
	docker-compose -f production.yml up -d game

up:

	docker-compose up -d

prod-up:

	docker-compose -f production.yml up -d

restart:

	docker-compose stop game && docker-compose up -d game

prod-restart:

	docker-compose -f production.yml stop game && docker-compose -f production.yml up -d game

run:

	docker exec -it craftcamp_website /bin/bash

stop:

	docker-compose stop

prod-stop:

	docker-compose -f production.yml stop

rm:

	docker-compose down

prod-rm:

	docker-compose -f production.yml down

build:

	tar -C volumes/apps -cvzf applications/website/archives/official_website.tar.gz official-website --exclude .git --exclude *.log
	docker-compose build

status:

	docker-compose ps

prod-status:

	docker-compose -f production.yml ps

build-all: build-website

build-website:

	$(eval version = $(shell git -C volumes/apps/official-website describe --tags))
	tar -C volumes/apps -cvzf applications/website/archives/official_website.tar.gz official-website --exclude .git --exclude *.log
	docker-compose build website
	docker tag craftcamp/website craftcamp/website:$(version)
	docker tag craftcamp/website craftcamp/website:latest
	docker push docker.io/craftcamp/website:$(version)
	docker push docker.io/craftcamp/website:latest
