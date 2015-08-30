#!/usr/bin/env bash
# script for run tests in clean system popstas/squeeze

set -e

service bind9 start > /dev/null
service mysql start > /dev/null

# install drupal-scripts
# -v $PWD:/user/local/src/drupal-scripts
#git clone https://github.com/popstas/drupal-scripts.git /usr/local/src/drupal-scripts
pushd /usr/local/src/drupal-scripts
./install.sh -y
popd

# install drupal
if [ ! -d build/drupal ]; then
	mkdir build
	mysql -e 'create database drupal;'
	echo "Install drupal..."
	drush -yq core-quick-drupal --profile=testing --no-server --db-url=mysql://root:mysql_pass@localhost/drupal build
fi

BATS_TESTS="${BATS_TESTS:-""}"
./run-tests.sh /usr/local/src/drupal-scripts/build/drupal "$BATS_TESTS"
