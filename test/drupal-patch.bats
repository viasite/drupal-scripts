#!/usr/bin/env bats

setup() {
	export file_to_patch=$(find themes -name "*.css" | head -n1)
	export file_to_patch_orig="drupal-patch-orig"
	export file_patched="drupal-patch-patched"
	export diff_file="drupal-patch-diff"
	export diff_string="5bcmjdtjhZSHWVZPxCPvW3T5MPREwGQvyvew4fjttEBmhDWrv674Fzw_wcZBRZdP"

	if [ ! -d .git ]; then
		git init
	fi

	cp "$file_to_patch" "$file_to_patch_orig"
	echo "$diff_string" >> "$file_to_patch"
	cp "$file_to_patch" "$file_patched"

	git diff "$file_to_patch" > "$diff_file"
	cp "$file_to_patch_orig" "$file_to_patch"
}

teardown() {
	cp "$file_to_patch_orig" "$file_to_patch"
	rm "$diff_file" "$file_to_patch_orig"
}

@test "patch without parameters" {
	run drs patch
	[ $status -eq 1 ]
}

@test "check test fixtures" {
	run bash -c 'diff -u "$file_to_patch_orig" "$file_patched" > "$diff_file"'
	[ $status -eq 1 ]

	run diff "$file_to_patch_orig" "$file_patched"
	[ $status -eq 1 ]
	[ "${lines[1]}" = "> $diff_string" ]
}

@test "patch success" {
	skip "drs patch sould be rewritten."
	run drs patch "$diff_file"
	#echo >&2 "$output"
	[ $status -eq 0 ]

	run diff "$file_to_patch" "$file_patched"
	echo >&2 diff "$file_to_patch" "$file_patched"
	#cat "$file_to_patch" >&2
	#echo >&2 "file_patched"
	#cat "$file_patched" >&2
	echo >&2 "$output"
	[ $status -eq 0 ]
}

@test "patch failed" {
	skip "drs patch sould be rewritten."
	run drs patch "$diff_file"
	echo >&2 "$output"
	[ $status -eq 0 ]

	run drs patch "$diff_file"
	echo >&2 "$output"
	[ $status -eq 1 ]
}

@test "patch from url" {
	skip "how to run test server?"
	run drs patch
	[ $status -eq 0 ]
}
