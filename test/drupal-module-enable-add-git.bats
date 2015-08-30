#!/usr/bin/env bats

setup() {
	# TODO: travis freezes on git init
	#if [ ! -d .git ]; then
	#	echo >&2 2
	#	git init
	#fi
	if [ -d .git ]; then
		true
		#git add .
		#git commit -m "test commit" >&2
		#git status >&2
		#cp -ar .git .git_test
	fi

	# TODO: rewrite
	#if [ "$(drs module-enabled -f yandex_metrics)" -eq 1 ]; then
	#    drs module-uninstall -y yandex_metrics
	#fi
}

teardown() {
	true
	#[ -d .git ] && rm -r .git && mv .git_test .git
}

@test "enable and commit module" {
	drush dis -y -q yandex_metrics
	run drs module-enable-add-git yandex_metrics
	[ $status -eq 0 ]

	ls -la . >&2

	run sh -c "git log -n1 --oneline | head -n1"
	echo >&2 "$output"
	[ $(echo "$output" | grep -c "modules: yandex_metrics") -eq 1 ]
}

@test "enable and commit module with comment" {
	random_comment=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)
	drush dis -y -q yandex_metrics
	run drs module-enable-add-git yandex_metrics "$random_comment"
	echo >&2 "$output"
	[ $status -eq 0 ]

	run sh -c "git log -n1 --oneline | head -n1"
	echo >&2 "$output"
	[ $(echo "$output" | grep -c "modules: yandex_metrics, $random_comment") -eq 1 ]
}

@test "try to enable enabled module" {
	run drs module-enable-add-git node
	[ $status -eq 1 ]

	run sh -c "git log -n1 --oneline | head -n1"
	[ $(echo "$output" | grep -c "modules: node") -eq 0 ]
}

@test "try to commit commited module" {
	drush dis -y -q yandex_metrics
	run drs module-enable-add-git yandex_metrics
	echo >&2 "$output"
	[ $status -eq 0 ]

	drush dis -y -q yandex_metrics
	run drs module-enable-add-git yandex_metrics
	echo >&2 "$output"
	[ $status -ne 0 ]

	run sh -c "git log -n1 --oneline | head -n1"
	echo >&2 "$output"
	[ $(echo "$output" | grep -c "modules: yandex_metrics") -ne 0 ]
}
