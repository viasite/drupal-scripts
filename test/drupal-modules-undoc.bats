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
	modules_count=$(drs modules-enabled | wc -l)
	undoc_expected=$(( $modules_count - 5 ))
	[ $status -eq 0 ]
	echo "$output" >&2
	echo "$modules_count" >&2
	drs modules-enabled >&2
	[ $(echo "$output" | wc -l) = "$undoc_expected" ]
}
