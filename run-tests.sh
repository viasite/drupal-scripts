#!/usr/bin/env bash

export DRUPAL_SCRIPTS_TEST=1

command -v bats >/dev/null 2>&1 || {
	echo >&2 "bats required but it's not installed, aborting."
	echo >&2 "https://github.com/sstephenson/bats"
	exit 1
}

export DRUPAL_SCRIPTS_ROOT_TEST=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd "$DRUPAL_SCRIPTS_ROOT_TEST"

. bin/drupal-scripts-init

export TEST_ROOT_PATH="$1"

if [ -z "$TEST_ROOT_PATH" ]; then
	echo >&2 "TEST_ROOT_PATH not defined, aborting tests."
	echo >&2 "Usage: run-tests.sh TEST_ROOT_PATH"
	echo >&2 ""
	echo >&2 "TEST_ROOT_PATH - path to test Drupal installation. Don't test on production site!"
	exit 1
fi

cd "$TEST_ROOT_PATH"

if [ -z "$(is_drupal)" ]; then
	echo >&2 "Test drupal not found, aborting tests."
	exit 1
fi

bats "$DRUPAL_SCRIPTS_ROOT"/test
