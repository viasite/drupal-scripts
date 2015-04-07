#!/usr/bin/env bats

@test "drs" {
	run drs
	[ $status -eq 1 ]
}

@test "drs help" {
	run drs help
	[ $status -eq 1 ]
	echo "$DRUPAL_SCRIPTS_ROOT_TEST" >&2
	echo "${#lines[@]}" >&2
	env >&2
	[ "${#lines[@]}" = $(find "$DRUPAL_SCRIPTS_ROOT_TEST"/commands -type f | wc -l) ]
}

@test "drs help command" {
	run drs help sql
	[ $status -eq 1 ]
	[ "$output" = "$("$DRUPAL_SCRIPTS_ROOT_TEST"/commands/drupal-sql --help)" ]
}
