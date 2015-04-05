#!/usr/bin/env bats

setup() {
	# TODO: SETUP_ONCE not visible, make it
	if [ -z "$SETUP_ONCE" ]; then
		drush vset "drupal_scripts_string" "foo"
		drush vset "drupal_scripts_true" "TRUE"
		drush vset "drupal_scripts_false" "FALSE"
		drush vset "drupal_scripts_empty" ""
		drush vset "drupal_scripts_array" $(php -r "echo serialize(array('foo'));")
	fi
	export SETUP_ONCE=1
}

@test "get true/false variable" {
	run drs vget drupal_scripts_true
	[ $status -eq 0 ]
	[ "$output" = "1" ]

	run drs vget drupal_scripts_false
	[ $status -eq 0 ]
	[ "$output" = "0" ]
}

@test "get string variable" {
	run drs vget drupal_scripts_string
	[ $status -eq 0 ]
	[ "$output" = "foo" ]
}

@test "get array variable" {
	# TODO cannot save array variable from drush
	skip "cannot save array variable from drush"
	run drs vget drupal_scripts_array
	[ $status -eq 0 ]
	[ "${#lines[0]}" = "Array" ]
}

@test "get empty variable" {
	run drs vget drupal_scripts_empty
	[ $status -eq 0 ]
	[ -z "$output" ]
}

@test "incorrect get variable" {
	run drs vget drupal_scripts_foo
	[ $status -eq 1 ]
	[ "$output" = "variable 'drupal_scripts_foo' not found" ]
}
