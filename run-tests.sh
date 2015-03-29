#!/usr/bin/env bash

command -v bats >/dev/null 2>&1 || {
	echo >&2 "bats required but it's not installed, aborting."
	echo >&2 "https://github.com/sstephenson/bats"
	exit 1
}

ROOT_PATH=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd "$ROOT_PATH"

. bin/drupal-scripts-init

if [ -z "$TEST_ROOT_PATH" ]; then
	echo >&2 "TEST_ROOT_PATH not defined, aborting tests."
	exit 1
fi

cd "$TEST_ROOT_PATH"

if [ -z "$(is_drupal)" ]; then
	echo >&2 "Test drupal not found, aborting tests."
	exit 1
fi

bats "$ROOT_PATH"/test
