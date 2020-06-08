FROM node:alpine

MAINTAINER Nicholas Elia <me@nichelia.com>

# Environment variables
ENV REFRESHED_AT 2020-06-08
ENV DEV_DIR="/usr/src"
ENV APP_DIR="${DEV_DIR}/blacklivesmatternow.info/blm/"
ENV USER="node"

# Set working directory
RUN mkdir -p ${APP_DIR} && \
    chown -R ${USER}:${USER} ${APP_DIR}
WORKDIR ${APP_DIR}

# Install machine dependencies
RUN apk add --no-cache \
  bash \
  git \
  vim

# Install node dependencies
COPY package*.json ${APP_DIR}
RUN npm i -g @angular/cli@9.1.5
RUN npm i -s @angular/flex-layout@9.0.0-beta.31 @angular/cdk@~9.2.1
RUN cd $APP_DIR && \
    npm install

# Switch Non-root user
USER ${USER}
