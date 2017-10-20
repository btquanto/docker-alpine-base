FROM alpine:3.6
MAINTAINER Quan To <btquanto@gmail.com>

# Variables
ENV APP_DIR /src
ENV APP_USER app
ENV APP_USER_UID 1000
ENV APP_USER_GID 1000

# app dir
RUN mkdir ${APP_DIR}
WORKDIR ${APP_DIR}

# install basic flask environment
RUN apk add --no-cache bash

COPY init.sh /init.sh

ENTRYPOINT ["/bin/bash", "/init.sh"]
