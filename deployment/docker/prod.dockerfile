FROM node:13.13.0-alpine AS compile-image

MAINTAINER Nicholas Elia <me@nichelia.com>

# Environment variables
ENV REFRESHED_AT 2020-06-06
ENV DEV_DIR="/usr/src"
ENV APP_DIR="${DEV_DIR}/blacklivesmatternow.info/blm/"

# Set working directory
RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR

# Copy needed files
COPY . $APP_DIR

# Install dependencies
RUN apk add --no-cache \
  bash \
  git \
  vim
RUN npm install -g @angular/cli@9.1.5
RUN npm i -s @angular/flex-layout@9.0.0-beta.31 @angular/cdk@~9.2.1

# Init project
RUN cd $APP_DIR && \
    npm install

RUN ng build --prod

# ----

FROM node:13.13.0-alpine AS build-image

MAINTAINER Nicholas Elia <me@nichelia.com>

# Environment variables
ENV REFRESHED_AT 2020-06-06
ENV DEV_DIR="/usr/src"
ENV APP_DIR="${DEV_DIR}/blacklivesmatternow.info/blm/"

# Set working directory
RUN mkdir -p $APP_DIR
WORKDIR $APP_DIR

RUN npm install express --save

COPY --from=compile-image /usr/src/blacklivesmatternow.info/blm/dist /usr/src/blacklivesmatternow.info/blm/dist
COPY --from=compile-image /usr/src/blacklivesmatternow.info/blm/server.js /usr/src/blacklivesmatternow.info/blm/server.js

EXPOSE 8080
CMD [ "node", "server.js" ]