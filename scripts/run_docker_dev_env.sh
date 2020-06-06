#!/usr/bin/env bash

###############################################################################
#
# Run Docker development environment
#
###############################################################################

# shellcheck disable=SC2034
script_name="$(basename -- "$0")"

# Colour Formats
# shellcheck disable=SC2034
bold="\033[1m"
# shellcheck disable=SC2034
green="\033[0;32m"
# shellcheck disable=SC2034
red="\033[91m"
# shellcheck disable=SC2034
no_color="\033[0m"


DOCKER_IMAGE_TAG="nichelia/blacklivesmatternow.info:dev"
if [[ "$(docker images -q ${DOCKER_IMAGE_TAG} 2> /dev/null)" == "" ]]; then
  echo -e "${red}Custom docker image \"${DOCKER_IMAGE_TAG}\" not found.${no_color}"
  echo -e "${green}Building docker image: \"${DOCKER_IMAGE_TAG}\"...${no_color}"
  docker build -f ./development/docker/dev.dockerfile -t "${DOCKER_IMAGE_TAG}" ./blm
fi

docker run --rm -it \
  --name blm-dev \
  -v "${PWD}/blm/e2e":/usr/src/blacklivesmatternow.info/blm/e2e \
  -v "${PWD}/blm/src":/usr/src/blacklivesmatternow.info/blm/src \
  -v "${PWD}/blm/.editorconfig":/usr/src/blacklivesmatternow.info/blm/.editorconfig \
  -v "${PWD}/blm/.gitignore":/usr/src/blacklivesmatternow.info/blm/.gitignore \
  -v "${PWD}/blm/angular.json":/usr/src/blacklivesmatternow.info/blm/angular.json \
  -v "${PWD}/blm/browserslist":/usr/src/blacklivesmatternow.info/blm/browserslist \
  -v "${PWD}/blm/karma.conf.js":/usr/src/blacklivesmatternow.info/blm/karma.conf.js \
  -v "${PWD}/blm/package-lock.json":/usr/src/blacklivesmatternow.info/blm/package-lock.json \
  -v "${PWD}/blm/package.json":/usr/src/blacklivesmatternow.info/blm/package.json \
  -v "${PWD}/blm/README.md":/usr/src/blacklivesmatternow.info/blm/README.md \
  -v "${PWD}/blm/tsconfig.app.json":/usr/src/blacklivesmatternow.info/blm/tsconfig.app.json \
  -v "${PWD}/blm/tsconfig.json":/usr/src/blacklivesmatternow.info/blm/tsconfig.json \
  -v "${PWD}/blm/tsconfig.spec.json":/usr/src/blacklivesmatternow.info/blm/tsconfig.spec.json \
  -v "${PWD}/blm/tslint.json":/usr/src/blacklivesmatternow.info/blm/tslint.json \
  -p 4200:4200 \
  nichelia/blacklivesmatternow.info:dev "$@"