#!/usr/bin/env bats

@test "sql connect" {
	run drs sql "SELECT 1"
	[ $status -eq 0 ]
	[ "$output" = "1" ]
}

@test "sql table replace" {
	run drs sql "SELECT COUNT(*) FROM {system}"
	drush_output=$(drush sqlq "SELECT COUNT(*) FROM system" --extra=--skip-column-names)
	[ $status -eq 0 ]
	[ "$output" = "$drush_output" ]
}

@test "sql prefix" {
	# TODO: sql prefix
	skip "How to check it?"
	run drs sql
	[ $status -eq 0 ]
	[ "$output" = "1" ]
}

@test "multirow sql" {
	run drs sql "SELECT name FROM {system} LIMIT 5"
	[ $status -eq 0 ]
	[ "${#lines[@]}" = "5" ]
}

@test "invalid sql" {
	run drs sql "SELECT name FROM foo"
	[ $status -eq 1 ]
	[ "$output" = "error" ]
}

@test "connect without port" {
	# TODO: connect without port
	skip
	run drs sql "SELECT 1"
	[ $status -eq 0 ]
	[ "$output" -eq 1 ]
}

@test "connect with danger symbols in password" {
	# TODO: connect with danger symbols in password
	skip
	run drs sql "SELECT 1"
	[ $status -eq 0 ]
	[ "$output" -eq 1 ]
}
