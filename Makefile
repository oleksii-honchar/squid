SHELL=/bin/bash
RED=\033[0;31m
GREEN=\033[0;32m
BG_GREY=\033[48;5;237m
YELLOW=\033[38;5;202m
NC=\033[0m # No Color
BOLD_ON=\033[1m
BOLD_OFF=\033[21m
CLEAR=\033[2J

export LATEST_VERSION=$(shell cat ./latest-version.txt)

.PHONY: help

help:
	@echo "tuiteraz/squid" automation commands:
	@echo
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(firstword $(MAKEFILE_LIST)) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

logs: ## docker logs
	@docker compose logs --follow

log: ## docker log for svc=<docker service name>
	@docker compose logs --follow ${svc}

up:  ## docker up, or svc=<svc-name>
	@docker compose up --build --remove-orphans -d ${svc}

down: ## docker down, or svc=<svc-name>
	@docker compose down ${svc}

.ONESHELL:
restart: ## restart all
	@docker compose down
	@docker compose up --build --remove-orphans -d
	@docker compose logs --follow

exec-sh: ## get shell for svc=<svc-name> container
	@docker exec -it ${svc} sh

build: 
	@docker build --load -f ./Dockerfile -t tuiteraz/squid:$(LATEST_VERSION) --platform linux/arm64 .

tag-latest: check-project-env-vars
	@docker tag tuiteraz/squid:$(LATEST_VERSION) tuiteraz/squid:latest

push: 
	@docker push docker.io/tuiteraz/squid:$(LATEST_VERSION)
	@docker push docker.io/tuiteraz/squid:latest