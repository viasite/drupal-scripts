#!/usr/bin/env bash

export DRUPAL_SCRIPTS_TEST=1
export DRUPAL_SCRIPTS_ROOT_TEST=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

command -v bats >/dev/null 2>&1 || {
	read -p "bats required but it's not installed, install bats? (y/n)? " -n 1 -r
	echo ""
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		git clone https://github.com/sstephenson/bats.git /usr/local/src/bats
		cd /usr/local/src/bats
		./install.sh /usr/local
	fi
}

command -v bats >/dev/null 2>&1 || {
	echo >&2 "bats required but it's not installed, aborting."
	echo >&2 "https://github.com/sstephenson/bats"
	exit 1
}

cd "$DRUPAL_SCRIPTS_ROOT_TEST"

. lib/drupal-scripts-init

export TEST_ROOT_PATH="$1"

if [ -z "$TEST_ROOT_PATH" ]; then
	echo >&2 "TEST_ROOT_PATH not defined, aborting tests.
Usage: run-tests.sh TEST_ROOT_PATH
       run-tests.sh TEST_ROOT_PATH module_name
       run-tests.sh TEST_ROOT_PATH --tap

TEST_ROOT_PATH - path to test Drupal installation. Don't test on production site!
module_name    - filename from /test without \".bats\", ex. code for run test /test/code.bats
--tap          - tap format output

Tests makes:
 - modules installation
"
	exit 1
fi

cd "$TEST_ROOT_PATH"

if [ -z "$(is_drupal)" ]; then
	echo >&2 "Test drupal not found, aborting tests."
	exit 1
fi

options=""
test_module="$2"
if [ "$test_module" = "--tap" ]; then
	test_module=""
	options="$options --tap"
fi
test_path="$DRUPAL_SCRIPTS_ROOT/test/$test_module.bats"
if [ -n "$test_module" ]; then
	if [ -r "$test_path" ]; then
		bats $options "$test_path"
	else
		echo >&2 "test $test_module not exists, aborting."
		exit 1
	fi
else
	bats $options "$DRUPAL_SCRIPTS_ROOT/test"
fi
