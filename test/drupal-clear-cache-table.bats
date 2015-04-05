#!/usr/bin/env bats

@test "no arguments prints usage instructions" {
	run drs clear-cache-table
	[ $status -eq 1 ]
	[ $(expr "${lines[0]}" : "drs clear-cache-table") -ne 0 ]
}

@test "clear cache_form" {
	run drs clear-cache-table cache_form
	[ $status -eq 0 ]
	[ -z "$output" ]
}

@test "clear cache_form verbose" {
	run drs clear-cache-table cache_form
	[ $status -eq 0 ]
	run drs clear-cache-table -v cache_form
	[ $status -eq 0 ]
	[ "$output" = "cleared 0 rows from cache_form" ]
}

@test "clear non-cache table" {
	run drs clear-cache-table node
	[ $status -eq 1 ]
}
