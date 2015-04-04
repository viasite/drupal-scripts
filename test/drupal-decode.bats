#!/usr/bin/env bats

setup() {
	export serialized_array="a:1:{i:0;i:1;}"
	export serialized_var='s:1:"1"'
}

@test "decode help" {
	run drupal-decode --help
	[ $status -eq 1 ]
}

@test "decode variable" {
	run drupal-decode $(php -r "echo serialize('1');")
	[ $status -eq 0 ]
	[ "$output" -eq 1 ]
}

@test "decode array" {
	run drupal-decode $(php -r "echo serialize(array('1'));")
	[ $status -eq 0 ]
	[ $(expr "${lines[0]}" : "Array") -ne 0 ]
}

@test "pipe decode" {
	run bash -c "php -r \"echo serialize('1');\" | drupal-decode"
	[ $status -eq 0 ]
	[ "$output" -eq 1 ]
}

@test "decode non-serialized string" {
	run drupal-decode 1
	[ $status -eq 1 ]
	#[ "$output" -eq 1 ]
}

@test "decode true" {
	run drupal-decode $(php -r "echo serialize(true);")
	[ $status -eq 0 ]
	[ "$output" -eq 1 ]
}

@test "decode false" {
	run drupal-decode $(php -r "echo serialize(false);")
	[ $status -eq 0 ]
	[ "$output" -eq 0 ]
}
