#!/bin/bash

PREFIX="$1"
DEFAULT_PREFIX="/usr/share"
BIN_PATH="/usr/local/bin"
DRUPAL_SCRIPTS_ROOT="$PWD"
USER_CONFIG_PATH="$HOME/.drupal-scripts.conf"
SCRIPT_ASSUME_YES=""

function usage(){
	echo "
Usage: $0 <prefix>
  e.g. $0 $DEFAULT_PREFIX

Options:
    -y Assume yes for all questions"

}

if [ "$1" = "--help" ]; then
	usage
	exit 1
fi

while getopts ":y" opt; do
	case "$opt" in
		y) SCRIPT_ASSUME_YES="1"
		shift
		;;
	esac
done

if [ ! -d "$PREFIX" ]; then
	if [ -z "$SCRIPT_ASSUME_YES" ]; then
		read -p "Install drupal-scripts to $DEFAULT_PREFIX (y/n)? " -n 1 -r
		echo ""
		if [[ ! $REPLY =~ ^[Yy]$ ]]; then
			echo "Aborting installation."
			exit 1
		fi
	fi

	PREFIX="$DEFAULT_PREFIX"
fi

if [ ! -d "$PREFIX" ]; then
	usage
	exit 1
fi

INSTALL_DIR="$PREFIX/drupal-scripts"

if [ -d "$INSTALL_DIR" ]; then
	echo "Previous installation detected."
	if [ -z "$SCRIPT_ASSUME_YES" ]; then
		read -p "Replace $INSTALL_DIR (y/n)? " -n 1 -r
		echo ""
		if [[ ! $REPLY =~ ^[Yy]$ ]]; then
			echo "Aborting installation."
			exit 1
		fi
	fi

	rm -r "$INSTALL_DIR"
	[ -h "$BIN_PATH"/drs ] && rm "$BIN_PATH"/drs
fi

cp -R "$DRUPAL_SCRIPTS_ROOT" "$INSTALL_DIR"

chmod +x "$INSTALL_DIR"/bin/*
chmod +x "$INSTALL_DIR"/commands/*
chmod +x "$INSTALL_DIR"/lib/*

ln -s "$INSTALL_DIR"/bin/drs "$BIN_PATH"

if [ ! -e "$USER_CONFIG_PATH" ]; then
	cp drupal-scripts.conf.example "$USER_CONFIG_PATH"
else
	echo "$USER_CONFIG_PATH exists, don't rewrite it."
fi

# replace DRUPAL_SCRIPTS_ROOT path in config
sed -i 's,DRUPAL_SCRIPTS_ROOT=.*,DRUPAL_SCRIPTS_ROOT="'"$INSTALL_DIR"'",g' "$USER_CONFIG_PATH"

echo "Installed drupal-scripts to $INSTALL_DIR.
Binary installed to $BIN_PATH/drs"
