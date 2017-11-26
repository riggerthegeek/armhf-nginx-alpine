DOCKER_IMG ?= "armhf-nginx-alpine"
DOCKER_USER ?= ""
VERSION = "1.13.6"

TAG_NAME = "${DOCKER_IMG}"
ifneq ($(DOCKER_USER), "")
TAG_NAME = "${DOCKER_USER}/${DOCKER_IMG}"
endif

build:
# 	Build the container
	docker build --build-arg NGINX_VERSION=${VERSION} --file ./Dockerfile --tag ${TAG_NAME}:latest .
	docker tag ${TAG_NAME}:latest ${TAG_NAME}:${VERSION}
.PHONY: build

publish:
	docker push ${TAG_NAME}:latest
	docker push ${TAG_NAME}:${VERSION}
.PHONY: publish
