#!/usr/bin/env bats

setup() {
	export sql_connect_line=$(drush sql-connect)
}

@test "get database wrong parameters" {
	run drupal-database-settings
	[ $status -eq 1 ]
	run drupal-database-settings foo
	[ $status -eq 1 ]
}

@test "get database username" {
	run drupal-database-settings username
	[ $status -eq 0 ]
	[ $(echo "$sql_connect_line" | grep -cw "\-\-user=$output") -eq 1 ]
}

@test "get database password" {
	run drupal-database-settings password
	[ $status -eq 0 ]
	[ $(echo "$sql_connect_line" | grep -cw "\-\-password=$output") -eq 1 ]
}

@test "get database name" {
	run drupal-database-settings database
	[ $status -eq 0 ]
	[ $(echo "$sql_connect_line" | grep -cw "\-\-database=$output") -eq 1 ]
}

@test "get database host" {
	run drupal-database-settings host
	[ $status -eq 0 ]
	[ $(echo "$sql_connect_line" | grep -cw "\-\-host=$output") -eq 1 ]
}

@test "get database port" {
	run drupal-database-settings port
	[ $status -eq 0 ]
	[ $(echo "$sql_connect_line" | grep -cw "\-\-port=$output") -eq 1 ]
}
