#!/usr/bin/env bats

@test "list all docs" {
	run drs module-doc
	[ $status -eq 0 ]
	[ $(echo "$output" | wc -l) = 6 ]
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

@test "list from custom docs_file" {
	docs_file="$DRUPAL_SCRIPTS_ROOT_TEST/example-data/modules.txt"
	run drs module-doc field_collection "$docs_file"
	[ $status -eq 0 ]
	[ $(echo "$output" | wc -l) = 2 ]
}

@test "list from invalid custom docs_file" {
	docs_file="$DRUPAL_SCRIPTS_ROOT_TEST/example-data/foo.txt"
	run drs module-doc field_collection "$docs_file"
	[ $status -eq 1 ]
	[ "$output" = "DOCS_FILE $docs_file not found" ]
}

@test "list undoc module" {
	run drs module-doc foo
	[ $status -eq 1 ]
	[ -z "$output" ]
}

@test "list undoc module with references" {
	run drs module-doc views
	[ $status -eq 1 ]
	[ -z "$output" ]
}
