IMAGE_NAME = octavo-docker
IMAGE_VERSION = 1.0
IMAGE_ORG = witekio
IMAGE_TAG = $(IMAGE_ORG)/$(IMAGE_NAME):$(IMAGE_VERSION)

WORKING_DIR := $(shell pwd)
DOCKERFILE_DIR := .

.DEFAULT_GOAL := build

.PHONY: run build push

run:: ## Runs the docker image
	@docker run \
            -it \
            --privileged \
            -v $(shell pwd)/../:/home/docker/octavo-build/ \
            -v /dev:/dev \
            $(IMAGE_ORG)/$(IMAGE_NAME):$(IMAGE_VERSION)

build:: ## Builds the docker image
	@echo Building $(IMAGE_TAG)
	@docker build \
	--build-arg PUID=$UID \
	--pull \
	-t $(IMAGE_TAG) $(DOCKERFILE_DIR)

push:: ## Pushes the docker image to the registry
	@echo Pushing $(IMAGE_TAG)
	@docker push $(IMAGE_TAG)

# A help target including self-documenting targets (see the awk statement)
define HELP_TEXT
Usage: make [TARGET]... [MAKEVAR1=SOMETHING]...

Available targets:
endef
export HELP_TEXT
help: ## This help target
	@echo
	@echo "$$HELP_TEXT"
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / \
