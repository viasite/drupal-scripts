#!/usr/bin/env bats

@test "sql connect" {
	run drupal-sql "SELECT 1"
	[ $status -eq 0 ]
	[ "$output" = "1" ]
}

@test "sql table replace" {
	run drupal-sql "SELECT COUNT(*) FROM {system}"
	drush_output=$(drush sqlq "SELECT COUNT(*) FROM system" --extra=--skip-column-names)
	[ $status -eq 0 ]
	[ "$output" = "$drush_output" ]
}

@test "sql prefix" {
	skip "How to check it?"
	run drupal-sql
	[ $status -eq 0 ]
	[ "$output" = "1" ]
}

@test "multirow sql" {
	run drupal-sql "SELECT name FROM {system} LIMIT 5"
	[ $status -eq 0 ]
	[ "${#lines[@]}" = "5" ]
}

@test "invalid sql" {
	run drupal-sql "SELECT name FROM foo"
	echo >&2 "$output"
	[ $status -eq 1 ]
	[ "$output" = "error" ]
}
