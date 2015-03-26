#!/bin/bash

PREFIX="$1"
DRUPAL_SCRIPTS_ROOT="$PWD"
USER_CONFIG_PATH="$HOME/.drupal-scripts.conf"

if [ -z "$PREFIX" ]; then
	echo "Usage: $0 <prefix>"
	echo "  e.g. $0 /usr/local"
	exit 1
fi


mkdir -p "$PREFIX"/bin
chmod +x "$DRUPAL_SCRIPTS_ROOT"/bin/*
ln -s "$DRUPAL_SCRIPTS_ROOT"/bin/* "$PREFIX"/bin
#cp -R "$DRUPAL_SCRIPTS_ROOT"/bin/* "$PREFIX"/bin

if [ ! -e "$USER_CONFIG_PATH" ]; then

cp drupal-scripts.conf.example "$USER_CONFIG_PATH"
else
	echo "$USER_CONFIG_PATH exists"
fi

echo "Installed drupal-scripts to $PREFIX/bin"
