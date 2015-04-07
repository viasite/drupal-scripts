#!/usr/bin/env bats

setup() {
	if [ "$(drs module-enabled -f node_export)" -ne 1 ]; then
		drush en -y -q node_export
	fi
	if [ "$(drs module-enabled -f yandex_metrics)" -ne 1 ]; then
		drush en -y -q yandex_metrics
	fi
}

@test "rm module without parameters" {
	run drs module-uninstall
	[ $status -eq 1 ]
}

@test "rm not existing module" {
	run drs module-uninstall foo
	[ $status -eq 1 ]
}

@test "rm module node" {
	run drs module-uninstall -y node
	[ $status -eq 1 ]
}

@test "rm module that required by other module" {
	run drs module-uninstall -y uuid
	[ $status -eq 1 ]
}

@test "rm module assume yes" {
	run drs module-uninstall -y yandex_metrics
	[ $status -eq 0 ]
	[ ! -d sites/all/modules/yandex_metrics ]
}

@test "rm module assume no" {
	run drs module-uninstall -n yandex_metrics 2>/dev/null
	[ $status -eq 0 ]
	[ -d sites/all/modules/yandex_metrics ]
	[ $(expr "${lines[3]}" : "rm") -ne 0 ]
}
