#!/usr/bin/env bats

setup() {
	find /tmp -maxdepth 1 -name "drupal-modules-enabled-*" -exec rm {} \;
	drush en -y yandex_metrics 2>/dev/null
}

teardown() {
	drush dis -y yandex_metrics 2>/dev/null
}

@test "get all modules" {
	run drupal-modules-enabled -f
	[ $status -eq 0 ]
	drush_output="$(drush pml --status=enabled --type=module --pipe | sort)"
	run diff <(echo "$output") <(echo "$drush_output")
	[ $status -eq 0 ]
}

@test "check cache" {
	run drupal-modules-enabled -f
	output1="$output"
	[ $status -eq 0 ]

	drush dis -y yandex_metrics
	run drupal-modules-enabled -f
	[ $status -eq 0 ]
	run diff <(echo "$output") <(echo "$output1")
	echo >&2 ""
	echo >&2 "$output"
	[ $status -eq 1 ]
	[ $(echo "$output" | wc -l) -eq 2 ]
	[ "${lines[1]}" = "> yandex_metrics" ]
}
