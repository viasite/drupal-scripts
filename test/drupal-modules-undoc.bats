#!/usr/bin/env bats

setup() {
	if [ "$(drs module-enabled -f devel)" != 1 ] \
	|| [ "$(drs module-enabled -f field_collection)" != 1 ] \
	|| [ "$(drs module-enabled -f field_collection_views)" != 1 ]
	then
		drush en -y -q devel field_collection field_collection_views
	fi
}

@test "list all undocs" {
	run drs modules-undoc
	modules_count=$(drs modules-enabled -f | wc -l)
	undoc_count=$(echo "$output" | wc -l)
	undoc_expected=$(( $modules_count - 5 ))
	[ $status -eq 0 ]
	echo >&2 "Found $undoc_count modules, expected $undoc_expected"
	echo >&2 "undoc:"
	echo >&2 "$output"
	echo >&2 ""
	echo >&2 "enabled:"
	drs modules-enabled >&2
	[ "$undoc_count" = "$undoc_expected" ]
}
