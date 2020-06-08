#!/usr/bin/env bash

###############################################################################
#
# Run Docker production environment
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

source ./scripts/docker_env.env

if [[ "$(docker images -q ${DOCKER_BASE_IMAGE_TAG} 2> /dev/null)" == "" ]]; then
  echo -e "${red}Docker image \"${DOCKER_BASE_IMAGE_TAG}\" not found.${no_color}"
  echo -e "${green}Building docker image: \"${DOCKER_BASE_IMAGE_TAG}\"...${no_color}"
  docker build -f ./docker/base.dockerfile -t "${DOCKER_BASE_IMAGE_TAG}" ./blm
fi

if [[ "$(docker images -q ${DOCKER_PROD_IMAGE_TAG} 2> /dev/null)" == "" ]]; then
  echo -e "${red}Docker image \"${DOCKER_PROD_IMAGE_TAG}\" not found.${no_color}"
  echo -e "${green}Building docker image: \"${DOCKER_PROD_IMAGE_TAG}\"...${no_color}"
  docker build -f ./docker/prod.dockerfile -t "${DOCKER_PROD_IMAGE_TAG}" ./blm
fi

echo -e "${green}Running docker image: \"${DOCKER_PROD_IMAGE_TAG}\" in prod mode...${no_color}"
docker run --rm -it \
  --name blm-prod \
  -p 8080:8080 \
  "${DOCKER_PROD_IMAGE_TAG}"