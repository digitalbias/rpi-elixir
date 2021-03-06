DOCKER_IMAGE_VERSION=1.5.3
DOCKER_IMAGE_NAME=digitalbias/rpi-elixir
DOCKER_IMAGE_TAGNAME=$(DOCKER_IMAGE_NAME):$(DOCKER_IMAGE_VERSION)

default: build

build:
	docker build -t $(DOCKER_IMAGE_TAGNAME) .
	docker tag $(DOCKER_IMAGE_TAGNAME) $(DOCKER_IMAGE_NAME):latest

push:
	docker push $(DOCKER_IMAGE_NAME)

test:
	docker run --rm $(DOCKER_IMAGE_TAGNAME) /bin/echo "Success."

version:
	docker run --rm $(DOCKER_IMAGE_TAGNAME) iex -v

rmi:
	docker rmi -f $(DOCKER_IMAGE_TAGNAME)

rebuild: rmi build
