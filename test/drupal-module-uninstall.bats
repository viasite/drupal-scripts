#!/usr/bin/env bats

setup() {
	if [ "$(drupal-module-enabled -f node_export)" -ne 1 ]; then
		drush en -y node_export
	fi
	if [ "$(drupal-module-enabled -f yandex_metrics)" -ne 1 ]; then
		drush en -y yandex_metrics
	fi
}

@test "rm module without parameters" {
	run drupal-module-uninstall
	[ $status -eq 1 ]
}

@test "rm not existing module" {
	run drupal-module-uninstall foo
	[ $status -eq 1 ]
}

@test "rm module node" {
	run drupal-module-uninstall -y node
	[ $status -eq 1 ]
}

@test "rm module that required by other module" {
	run drupal-module-uninstall -y uuid
	[ $status -eq 1 ]
}

@test "rm module assume yes" {
	run drupal-module-uninstall -y yandex_metrics
	[ $status -eq 0 ]
	[ ! -d sites/all/modules/yandex_metrics ]
}

@test "rm module assume no" {
	run drupal-module-uninstall -n yandex_metrics 2>/dev/null
	[ $status -eq 0 ]
	[ -d sites/all/modules/yandex_metrics ]
	[ $(expr "${lines[3]}" : "rm") -ne 0 ]
}
