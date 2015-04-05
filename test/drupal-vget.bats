#!/usr/bin/env bats

setup() {
	# TODO: SETUP_ONCE not visible, make it
	if [ -z "$SETUP_ONCE" ]; then
		drush vset "drupal_scripts_string" "foo"
		drush vset "drupal_scripts_true" "true"
		drush vset "drupal_scripts_false" "false"
		drush vset "drupal_scripts_empty" ""
		drush vset "drupal_scripts_array" $(php -r "echo serialize(array('foo'));")
	fi
	export SETUP_ONCE=1
}

@test "get true/false variable" {
	run drs vget drupal_scripts_true
	[ $status -eq 0 ]
	echo >&2 "$output"
	[ "$output" = "1" ]
	run drs vget drupal_scripts_false
	[ $status -eq 0 ]
	echo >&2 "$output"
	[ "$output" = "0" ]
}

@test "get string variable" {
	run drs vget drupal_scripts_string
	echo >&2 "$output"
	[ $status -eq 0 ]
	[ "$output" = "foo" ]
}

@test "get array variable" {
	# TODO cannot decode array variable
	skip "cannot decode array variable"
	run drs vget drupal_scripts_array
	echo >&2 "$output"
	[ $status -eq 0 ]
	[ "$output" = "a:1:{i:0;s:3:\"foo\";}" ]
}

@test "get empty variable" {
	run drs vget drupal_scripts_empty
	echo >&2 "$output"
	[ $status -eq 0 ]
	[ -z "$output" ]
}

@test "incorrect get variable" {
	run drs vget drupal_scripts_foo
	echo >&2 "$output"
	[ $status -eq 1 ]
	[ "$output" = "variable 'drupal_scripts_foo' not found" ]
}
