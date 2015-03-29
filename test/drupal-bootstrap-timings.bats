#!/usr/bin/env bats

@test "bootstrap timings output 5 lines" {
	run drupal-bootstrap-timings
	[ $status -eq 0 ]
	[ $(echo "$output" | wc -l) -eq 5 ]
}
