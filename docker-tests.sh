#!/usr/bin/env bash
# script for run tests in clean system popstas/squeeze

set -e

DB=drupal_scripts_test
DB_PASS=mysql_pass

service bind9 start > /dev/null
service mysql start > /dev/null

# install drupal-scripts
# -v $PWD:/user/local/src/drupal-scripts
#git clone https://github.com/popstas/drupal-scripts.git /usr/local/src/drupal-scripts
pushd /usr/local/src/drupal-scripts
./install.sh -y
popd

# install drupal
isdb=$(mysql -Brs --execute="SHOW DATABASES LIKE '$DB'" | wc -l)
if [ "$isdb" = 0 ]; then
	mysql -e 'create database $DB;'
fi

if [ ! -d build/drupal ] || [ "$isdb" = 0 ]; then
	mkdir -p build
	rm -rf build/drupal
	echo "Install drupal..."
	drush -yq core-quick-drupal --profile=testing --no-server --db-url=mysql://root:$DB_PASS@localhost/$DB build
fi

BATS_TESTS="${BATS_TESTS:-""}"
./run-tests.sh /usr/local/src/drupal-scripts/build/drupal "$BATS_TESTS"
