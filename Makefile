DOCKER_IMG ?= "armhf-nginx-alpine"
DOCKER_USER ?= ""

VERSION = "1.13.7"
VERSION_MAJOR = "1"
VERSION_MINOR = "1.13"
VERSION_TYPE = "latest"

TAG_NAME = "${DOCKER_IMG}"
ifneq ($(DOCKER_USER), "")
TAG_NAME = "${DOCKER_USER}/${DOCKER_IMG}"
endif

build:
# 	Build the container
	docker build --build-arg NGINX_VERSION=${VERSION} --file ./Dockerfile --tag ${TAG_NAME}:${VERSION_TYPE} .
	docker tag ${TAG_NAME}:${VERSION_TYPE} ${TAG_NAME}:${VERSION}
	docker tag ${TAG_NAME}:${VERSION_TYPE} ${TAG_NAME}:${VERSION_MAJOR}
	docker tag ${TAG_NAME}:${VERSION_TYPE} ${TAG_NAME}:${VERSION_MINOR}
.PHONY: build

publish:
	docker push ${TAG_NAME}:${VERSION_TYPE}
	docker push ${TAG_NAME}:${VERSION}
	docker push ${TAG_NAME}:${VERSION_MAJOR}
	docker push ${TAG_NAME}:${VERSION_MINOR}
.PHONY: publish
