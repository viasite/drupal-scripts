#!/usr/bin/env bash

export DRUPAL_SCRIPTS_TEST=1

command -v bats >/dev/null 2>&1 || {
	echo >&2 "bats required but it's not installed, aborting."
	echo >&2 "https://github.com/sstephenson/bats"
	exit 1
}

export DRUPAL_SCRIPTS_ROOT_TEST=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd "$DRUPAL_SCRIPTS_ROOT_TEST"

. lib/drupal-scripts-init

export TEST_ROOT_PATH="$1"

if [ -z "$TEST_ROOT_PATH" ]; then
	echo >&2 "TEST_ROOT_PATH not defined, aborting tests.
Usage: run-tests.sh TEST_ROOT_PATH

TEST_ROOT_PATH - path to test Drupal installation. Don't test on production site!

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

test_module="$2"
test_path="$DRUPAL_SCRIPTS_ROOT/test/$test_module.bats"
if [ -n "$test_module" ] && [ -r "$test_path" ]; then
	bats "$test_path"
else
	bats "$DRUPAL_SCRIPTS_ROOT/test"
fi
