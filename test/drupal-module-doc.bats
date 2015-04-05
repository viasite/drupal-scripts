#!/usr/bin/env bats

@test "list all docs" {
	run drs module-doc
	[ $status -eq 0 ]
	[ $(echo "$output" | wc -l) = 5 ]
}

@test "list one module" {
	run drs module-doc devel
	[ $status -eq 0 ]
	[ $(echo "$output" | wc -l) = 1 ]
}

@test "list module with references" {
	run drs module-doc field_collection
	[ $status -eq 0 ]
	[ $(echo "$output" | wc -l) = 2 ]
}

@test "list undoc module" {
	run drs module-doc foo
	[ $status -eq 1 ]
	echo >&2 "\"$output\""
	echo >&2 $(echo "$output" | wc -l)
	[ -z "$output" ]
}
