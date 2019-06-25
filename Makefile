.DEFAULT_GOAL := help

BUILD_TIMESTAMP ?= `date +%Y%m%d`
VERSION			:= 0.1.0
USER         := ronaldgcr
TAG_DEV			:= $(USER)/jenkis-docker-aws:$(VERSION)
AWS_CREDENTIALS = ~/.aws:/root/.aws

build-jenkins:
	docker build -t $(TAG_DEV) docker/jenkins

install-library:
	docker run -it $(TAG_DEV) $(COMMAND)

start:
	sudo chmod 777 -R jenkins-data
	docker run -it --rm  -u root -p 8080:8080 -v $(AWS_CREDENTIALS) -v $(PWD)/jenkins-data:/var/jenkins_home -v /var/run/docker.sock:/var/run/docker.sock $(TAG_DEV)

ssh-jenkins:
	docker run -it $(TAG_DEV) bash

help: ## ayuda: make help
	@printf "\033[31m%-16s %-59s %s\033[0m\n" "Target" "Help" "Usage"; \
	printf "\033[31m%-16s %-59s %s\033[0m\n" "------" "----" "-----"; \
	grep -hE '^\S+:.*## .*$$' $(MAKEFILE_LIST) | sed -e 's/:.*##\s*/:/' | sort | awk 'BEGIN {FS = ":"}; {printf "\033[32m%-16s\033[0m %-58s \033[34m%s\033[0m\n", $$1, $$2, $$3}'
