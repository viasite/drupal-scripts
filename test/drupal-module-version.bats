#!/usr/bin/env bats

@test "check module version" {
	run drs module-version node
	[ $status -eq 0 ]
	[ $(grep -c "version = \"$output\"" "modules/node/node.info") -eq 1 ]
}

@test "check not exists module version" {
	run drs module-version node2
	[ $status -eq 1 ]
	[ -z "$output" ]
}
