#!/usr/bin/env bats

@test "list all docs" {
	run drupal-module-doc
	[ $status -eq 0 ]
	[ $(echo "$output" | wc -l) = 3 ]
}

@test "list one module" {
	run drupal-module-doc devel
	[ $status -eq 0 ]
	[ $(echo "$output" | wc -l) = 1 ]
}

@test "list module with references" {
	run drupal-module-doc field_collection
	[ $status -eq 0 ]
	[ $(echo "$output" | wc -l) = 2 ]
}

@test "list undoc module" {
	run drupal-module-doc foo
	[ $status -eq 1 ]
	echo >&2 "\"$output\""
	echo >&2 $(echo "$output" | wc -l)
	[ -z "$output" ]
}
