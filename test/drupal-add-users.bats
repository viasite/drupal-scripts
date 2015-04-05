#!/usr/bin/env bats

users_file="$BATS_TEST_DIRNAME"/../example-data/users.txt
user_line=$(head -n1 "$users_file")
login=$(echo "$user_line" | cut -d' ' -f1)
role=$(echo "$user_line" | cut -d' ' -f2)
password=$(echo "$user_line" | cut -d' ' -f3)

@test "drs add-users without arguments" {
	run drs add-users
	echo "$output"
	[ $status -eq 1 ]
	[ $(expr "${lines[0]}" : "drupal-add-users") -ne 0 ]
}

@test "add single user" {
	run drush ucan -y "$login"
	run drs add-users "$login"
	[ $status -eq 0 ]
	run drush uinf "$login"
	[ $status -eq 0 ]
}

@test "add single existing user" {
	run drush ucan -y "$login"
	run drs add-users "$login"
	run drs add-users "$login"
	[ $status -eq 0 ]
	[ $(expr "${lines[0]}" : "$login exists") -ne 0 ]
}

@test "add single user with role" {
	run drush ucan -y "$login"
	run drush role-create -y "$role"
	run drs add-users "$login" "$role"
	[ $status -eq 0 ]
	run drush uinf "$login"
	[ $status -eq 0 ]
	[ $(echo "$output" | grep -c "$role") -ne 0 ]
}

@test "add single user with non-existing role" {
	run drush ucan -y "$login"
	run drush role-delete -y "$role"
	run drs add-users "$login" "$role"
	[ $status -eq 0 ]
	[ $(expr "${lines[0]}" : "There is no role") -ne 0 ]
}

@test "add users from file" {
	run drs add-users all "$users_file"
	[ $status -eq 0 ]

	users_list=""
	while read line; do
		line_login=$(echo $line | cut -d' ' -f1)
		users_list="$users_list$line_login,"
	done < "$users_file"
	run drush uinf "$users_list"
	[ $status -eq 0 ]
}

@test "add users from non-existing file" {
	run drs add-users all "${users_file}2"
	[ $status -eq 1 ]
}
