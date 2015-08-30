#!/usr/bin/env bats

@test "drs" {
	run drs
	[ $status -eq 1 ]
}

@test "drs help" {
	run drs help
	expected_commands=$(find "$DRUPAL_SCRIPTS_ROOT_TEST"/commands -type f | wc -l)
	echo >&2 "Expected $expected_commands commands, found ${#lines[@]}"
	echo >&2 "$output"
	[ $status -eq 1 ]
	[ "${#lines[@]}" = "$expected_commands" ]
}

@test "drs help command" {
	run drs help sql
	[ $status -eq 1 ]
	[ "$output" = "$("$DRUPAL_SCRIPTS_ROOT_TEST"/commands/drupal-sql --help)" ]
}
