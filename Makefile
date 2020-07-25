SHELL := /bin/bash

MODULE=blm

### Environment ###
.PHONY: env
env:
	./scripts/helpers/environment.sh -f

.PHONY: env-prod
env-prod:
	./scripts/helpers/environment.sh -p

.PHONY: env-update
env-update:
	./scripts/helpers/environment.sh -u

### Docker ###
.PHONY: build-docker-test
build-docker-local:
	./scripts/build_docker_image.sh -t

.PHONY: build-docker
build-docker:
	./scripts/build_docker_image.sh

### Run ###
.PHONY: run
run:
	./scripts/run.sh

run-prod:
	./scripts/run.sh -p

### Lint ###
.PHONY: lint
lint:
	cd blm && ng lint

### Test ###
.PHONY: test
test:
	cd blm && ng test

.PHONY: test-coverage
test-coverage:
	cd blm && ng test --no-watch --code-coverage

### Util ###
.PHONY : clean
clean :
	./scripts/helpers/cleanup.sh -d
