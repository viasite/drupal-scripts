#!/usr/bin/env bats

setup() {
	if [ "$(drupal-module-enabled -f node_export)" -ne 1 ]; then
        drush en -y node_export 2>/dev/null
	fi
	if [ "$(drupal-module-enabled -f yandex_metrics)" -ne 1 ]; then
        drush en -y yandex_metrics 2>/dev/null
	fi
}

@test "rm module without parameters" {
	skip
	run drupal-module-uninstall
	[ $status -eq 1 ]
}

@test "rm not existing module" {
	skip
	run drupal-module-uninstall foo
	[ $status -eq 1 ]
}

@test "rm module node" {
	skip
	run drupal-module-uninstall -y node
	[ $status -eq 1 ]
}

@test "rm module that required by other module" {
	skip
	run drupal-module-uninstall -y uuid
	[ $status -eq 1 ]
}

@test "rm module assume yes" {
	skip
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
