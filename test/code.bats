#!/usr/bin/env bats

@test "check test debug outputs" {
	run bash -c 'grep -rc ">&2" "$DRUPAL_SCRIPTS_ROOT_TEST/test" | grep -v "code.bats" | grep -v :0'
	echo >&2 "$output"
	[ $status -eq 1 ]
	[ "${#lines[@]}" -eq 0 ]
}
