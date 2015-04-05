#!/usr/bin/env bats

@test "correct sql table count" {
	run drs table-count system
	drush_output=$(drush sqlq "SELECT COUNT(*) FROM system" --extra=--skip-column-names)
	[ $status -eq 0 ]
	[ "$output" = "$drush_output" ]
}

@test "incorrect sql table count" {
	run drs table-count foo
	[ $status -eq 1 ]
	[ "$output" -eq 0 ]
}
