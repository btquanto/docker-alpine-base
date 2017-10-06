#!/bin/bash

if [ ! $(id -u $APP_USER) ]
then
    echo "User '$APP_USER' do not exist. Creating user..."
    adduser -D -u $APP_USER_UID $APP_USER
    echo "User '$APP_USER' is created with id $(id -u $APP_USER)"
fi

SCRIPT_PATH="$APP_DIR/$SCRIPT"

if [ -n "$SCRIPT" ]
then
    if [ -f $SCRIPT_PATH ]
    then
        if [ -x $SCRIPT_PATH ]
        then
            su $APP_USER -c "$APP_DIR/$SCRIPT"
        else
            echo "$SCRIPT_PATH is not executable"
        fi
    else
        echo "$SCRIPT_PATH doesn't exist"
    fi
else
    echo "No scripts specified."
    echo "Please define a SCRIPT environment variable pointing to an executable file in the /src folder"
    echo "Example of a docker-compose.yml file:"
    echo "
version: '3.2'
services:
  alpine:
    image: btquanto/alpine_base
    environment:
      - APP_USER_UID=1000
      - APP_USER_GID=1000
      - SCRIPT=run.sh
    volumes:
      - ./:/src
"
fi

