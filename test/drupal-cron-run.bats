#!/usr/bin/env bats

@test "run cron without parameters" {
	run drupal-cron-run
	[ $status -eq 1 ]
}

@test "run cron with root_path" {
	run drupal-cron-run -s "$TEST_ROOT_PATH"
	[ $status -eq 0 ]
}

@test "run cron with root_path and command" {
	run drupal-cron-run "$TEST_ROOT_PATH" "st"
	[ $status -eq 0 ]
	[ $(echo "$output" | grep -c "http://$(basename "$PWD")") -eq 1 ]
}

@test "run cron with root_path, command and domain" {
	run drupal-cron-run "$TEST_ROOT_PATH" "st" "example.com"
	[ $status -eq 0 ]
	[ $(echo "$output" | grep -c "http://example.com") -eq 1 ]
}
