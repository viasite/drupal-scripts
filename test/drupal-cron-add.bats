#!/usr/bin/env bats

setup() {
	export test_user=$(stat -c '%U' "$PWD")
	temp_file=$(mktemp -t drupal-cron-add-test-XXXX)

	# save crontab
	if [ -n "$(crontab -l -u "$test_user" 2>/dev/null)" ]; then
		crontab -l -u "$test_user" > "$temp_file"
		cat "" | crontab -u "$test_user" -
	fi
	# clean crontab
}

teardown() {
	# restore crontab
	cat "$temp_file" | crontab -u "$test_user" -
	rm -f "$temp_file"
}

@test "add cron to new user" {
	run drs cron-add
	[ $status -eq 0 ]
	[ $(crontab -l -u "$test_user" | wc -l) -eq 1 ]
}

@test "duplicate add to cron" {
	run drs cron-add
	[ $status -eq 0 ]
	run drs cron-add
	[ $status -eq 0 ]
	[ $(crontab -l -u "$test_user" | wc -l) -eq 1 ]
}
