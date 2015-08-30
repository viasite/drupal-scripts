# drupal-scripts

Shell scripts for Drupal.

Main purposes: 20-50 times faster than Drush. 
- quickly get information across many Drupal sites in server
- bulk operations with Drupal sites

All commands should run from drupal site root_path.

Some commands expects that contrib modules place in sites/all/modules.

Some commands has same functions as drush commands but not initializes drupal bootstrap (50-300 msec faster execution)

Tested on Debian Squeeze and Ubuntu 14.04.

[![Build Status](https://travis-ci.org/popstas/drupal-scripts.svg?branch=0.2)](https://travis-ci.org/popstas/drupal-scripts)

# Requirements
- Drush 6.x
- Drupal 7.x

# Install
```
./install.sh
```

# Commands docs
See [commands docs](docs/commands.md)

# Testing
<a href="http://ci.viasite.ru/viewType.html?buildTypeId=DrupalScripts_Build">
<img src="http://ci.viasite.ru/app/rest/builds/buildType:(id:DrupalScripts_Build)/statusIcon"/></a>

Run tests in docker environment:
```
cd drupal-scripts
docker run --rm -v $PWD:/usr/local/src/drupal-scripts popstas/squeeze bash ./docker-tests.sh
```

You can run tests `./run-tests` in any drupal root directory, it not modifies drupal.


# TODO
## v0.1
- [x] move shared code to drupal-scripts-init
- [x] replace $(basename $PWD) to get_domain
- [x] write tests
- [x] write docs and move to /docs
- [x] spaces to tabs
- [x] drs sql: add host and port to connect string

## v0.2
- [x] move commands to subdir
- [x] drs wrapper
- [x] installer: rewrite drupal scripts root in conf.example
- [x] correct exit codes
- [x] move all errors to stderr
- [x] zsh autocomplete
- [ ] Travis CI
- [ ] drupal-module-install tests
- [ ] drupal-urls tests

## v0.3
- [ ] global version
- [ ] setup once in tests
- [ ] installer: tests
- [ ] drs module-enabled: check directory exists
- [ ] drs module-enabled: multicheck
- [ ] drs modules-undoc: more precise check for undoc
- [ ] bash multi flags