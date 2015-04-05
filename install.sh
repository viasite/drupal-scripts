#!/bin/bash

PREFIX="$1"
DEFAULT_PREFIX="/usr/share"
BIN_PATH="/usr/local/bin"
DRUPAL_SCRIPTS_ROOT="$PWD"
USER_CONFIG_PATH="$HOME/.drupal-scripts.conf"

function usage(){
	echo >&2 "Usage: $0 <prefix>"
	echo >&2 "  e.g. $0 $DEFAULT_PREFIX"
}

if [ ! -d "$PREFIX" ]; then
	usage
	read -p "Install drupal-scripts to $DEFAULT_PREFIX (y/n)? " -n 1 -r
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		PREFIX="$DEFAULT_PREFIX"
	fi
fi

if [ ! -d "$PREFIX" ]; then
	usage
	exit 1
fi

INSTALL_DIR="$PREFIX/drupal-scripts"

if [ -d "$INSTALL_DIR" ]; then
	read -p "Previous installation detected. Replace $INSTALL_DIR (y/n)? " -n 1 -r
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		rm -r "$INSTALL_DIR"
		[ -f "$BIN_PATH"/drs ] && rm "$BIN_PATH"/drs
	else
		echo >&2 "Aborting installation."
		exit 1
	fi
fi

cp -R "$DRUPAL_SCRIPTS_ROOT" "$INSTALL_DIR"

chmod +x "$INSTALL_DIR"/bin/*
chmod +x "$INSTALL_DIR"/commands/*
chmod +x "$INSTALL_DIR"/lib/*

ln -s "$INSTALL_DIR"/bin/drs "$BIN_PATH"

if [ ! -e "$USER_CONFIG_PATH" ]; then
	cp drupal-scripts.conf.example "$USER_CONFIG_PATH"
else
	echo "$USER_CONFIG_PATH exists"
fi

sed -i 's,DRUPAL_SCRIPTS_ROOT=.*,DRUPAL_SCRIPTS_ROOT="'"$INSTALL_DIR"'",g' "$USER_CONFIG_PATH"

echo "Installed drupal-scripts to $INSTALL_DIR.
Binary installed to $BIN_PATH/drs"
