#!/usr/bin/env bats

setup() {
	if [ "$(drs module-enabled -f block)" != 1 ]; then
		drush en -y -q block
	fi
}

@test "block timings line has 4 columns" {
	run drs block-timings
	[ $status -eq 0 ]
	[ $(echo "${lines[0]}" | head -n1 | tr -cd , | wc -c) -eq 3 ]
}
