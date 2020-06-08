#!/usr/bin/env bash

###############################################################################
#
# Run Docker cleanup
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
  echo -e "${green}Docker image \"${DOCKER_BASE_IMAGE_TAG}\" not found.${no_color}"
else
  echo -e "${red}Docker image \"${DOCKER_BASE_IMAGE_TAG}\" found. Removing...${no_color}"
  docker rmi ${DOCKER_BASE_IMAGE_TAG}
fi

if [[ "$(docker images -q ${DOCKER_DEV_IMAGE_TAG} 2> /dev/null)" == "" ]]; then
  echo -e "${green}Docker image \"${DOCKER_DEV_IMAGE_TAG}\" not found.${no_color}"
else
  echo -e "${red}Docker image \"${DOCKER_DEV_IMAGE_TAG}\" found. Removing...${no_color}"
  docker rmi ${DOCKER_DEV_IMAGE_TAG}
fi

if [[ "$(docker images -q ${DOCKER_PROD_IMAGE_TAG} 2> /dev/null)" == "" ]]; then
  echo -e "${green}Docker image \"${DOCKER_PROD_IMAGE_TAG}\" not found.${no_color}"
else
  echo -e "${red}Docker image \"${DOCKER_PROD_IMAGE_TAG}\" found. Removing...${no_color}"
  docker rmi ${DOCKER_PROD_IMAGE_TAG}
fi

if [[ "$(docker volume inspect ${DOCKER_DEV_VOLUME} 2> /dev/null)" == "" ]]; then
  echo -e "${green}Docker volume \"${DOCKER_DEV_VOLUME}\" not found.${no_color}"
else
  echo -e "${red}Docker volume \"${DOCKER_DEV_VOLUME}\" found. Removing...${no_color}"
  docker volume rm ${DOCKER_DEV_VOLUME}
fi