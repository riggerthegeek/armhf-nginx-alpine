DOCKER_IMG ?= "armhf-nginx-alpine"
DOCKER_USER ?= ""
VERSION = "1.13.6"
VERSION_MAJOR = "1"
VERSION_MINOR = "1.13"

TAG_NAME = "${DOCKER_IMG}"
ifneq ($(DOCKER_USER), "")
TAG_NAME = "${DOCKER_USER}/${DOCKER_IMG}"
endif

build:
# 	Build the container
	docker build --build-arg NGINX_VERSION=${VERSION} --file ./Dockerfile --tag ${TAG_NAME}:latest .
	docker tag ${TAG_NAME}:latest ${TAG_NAME}:${VERSION}
	docker tag ${TAG_NAME}:latest ${TAG_NAME}:${VERSION_MAJOR}
	docker tag ${TAG_NAME}:latest ${TAG_NAME}:${VERSION_MINOR}
.PHONY: build

publish:
	docker push ${TAG_NAME}:latest
	docker push ${TAG_NAME}:${VERSION}
	docker push ${TAG_NAME}:${VERSION_MAJOR}
	docker push ${TAG_NAME}:${VERSION_MINOR}
.PHONY: publish
