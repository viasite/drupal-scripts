#!/bin/bash

DEFAULT_PREFIX="/usr/share"
BIN_PATH="/usr/local/bin"
DRUPAL_SCRIPTS_ROOT="$PWD"
CONFIG_PATH="/etc/drupal-scripts.conf"
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

PREFIX="$1"
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

INSTALL_DIR="$PREFIX/drupal-scripts"
if [ ! -w "$PREFIX" ]; then
	echo "You cannot write to $INSTALL_DIR, aborting."
	exit 1
fi

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

	rm -rf "$INSTALL_DIR"
	[ -w "$BIN_PATH"/drs ] && [ -h "$BIN_PATH"/drs ] && rm "$BIN_PATH"/drs
fi

cp -R "$DRUPAL_SCRIPTS_ROOT" "$INSTALL_DIR"

chmod +x "$INSTALL_DIR"/bin/*
chmod +x "$INSTALL_DIR"/commands/*
chmod +x "$INSTALL_DIR"/lib/*

[ -w "$BIN_PATH" ] \
&& ln -s "$INSTALL_DIR"/bin/drs "$BIN_PATH" 2>/dev/null \
&& echo "Binary installed to $BIN_PATH/drs"

if [ ! -e "$CONFIG_PATH" ]; then
	cp drupal-scripts.conf.example "$CONFIG_PATH"
else
	echo "$CONFIG_PATH exists, don't rewrite it."
fi

# replace DRUPAL_SCRIPTS_ROOT path in config
sed -i 's,DRUPAL_SCRIPTS_ROOT=.*,DRUPAL_SCRIPTS_ROOT="'"$INSTALL_DIR"'",g' "$CONFIG_PATH"

echo "Installed drupal-scripts to $INSTALL_DIR."
