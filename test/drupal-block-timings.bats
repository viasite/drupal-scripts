#!/usr/bin/env bats

@test "block timings line has 4 columns" {
	run drs block-timings
	[ $status -eq 0 ]
	[ $(echo "${lines[0]}" | head -n1 | tr -cd , | wc -c) -eq 3 ]
}
