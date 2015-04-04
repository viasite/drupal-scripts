# drupal-scripts

Shell scripts for Drupal.

Main purposes:
- quickly get information across many Drupal sites in server
- bulk operations with Drupal sites

All scripts should run from drupal site root_path.

Some scripts expects that contrib modules place in sites/all/modules.

Some scripts has same functions as drush commands but not initializes drupal bootstrap (50-300 msec faster execution)

Tested on Debian Squeeze and Ubuntu 14.04.

# Requirements
- Drush
- Drupal 7.x

# Install
sh install.sh /usr/local

# Scripts docs
See [scripts docs](docs/scripts.md)

# TODO
## v0.1
- [x] move shared code to drupal-scripts-init
- [x] replace $(basename $PWD) to get_domain
- [x] write tests
- [x] write docs and move to /docs
- [x] spaces to tabs

## v0.2
- [ ] installer: rewrite drupal scripts root in conf.example
- [ ] global version
- [ ] setup once in tests
- [ ] correct exit codes
- [ ] drupal-module-enabled: check directory exists
- [ ] drupal-module-enabled: multicheck
- [ ] drupal-modules-undoc: more precise check for undoc
- [ ] drupal-sql: add host and port to connect string
- [ ] drupal-scripts wrapper
