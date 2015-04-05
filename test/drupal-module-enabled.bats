#!/usr/bin/env bats

setup() {
	find /tmp -maxdepth 1 -name "drupal-modules-enabled-*" -exec rm {} \;
}

@test "check enabled module" {
	drush en -y yandex_metrics
	run drs module-enabled -f yandex_metrics
	[ $status -eq 0 ]
	[ "$output" -eq 1 ]
}

@test "check disabled module" {
	drush dis -y yandex_metrics
	run drs module-enabled -f yandex_metrics
	[ $status -eq 1 ]
	[ "$output" -eq 0 ]
}

@test "check cache module" {
	drush en -y yandex_metrics
	run drs module-enabled -f yandex_metrics
	[ $status -eq 0 ]
	[ "$output" -eq 1 ]

	drush dis -y yandex_metrics
	run drs module-enabled yandex_metrics
	[ $status -eq 0 ]
	[ "$output" -eq 1 ]
}

@test "check incorrect deleted module" {
	# TODO: check incorrect deleted module
	skip
}
