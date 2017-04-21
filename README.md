# drupal-scripts

Shell scripts for Drupal.

Main purposes: 20-50 times faster than Drush. 
- quickly get information across many Drupal sites in server
- bulk operations with Drupal sites

All commands should run from drupal site root_path.

Some commands expects that contrib modules place in sites/all/modules.

Some commands has same functions as drush commands but not initializes drupal bootstrap (50-300 msec faster execution)

Tested on Debian Squeeze and Ubuntu 14.04.

<a href="http://ci.viasite.ru/viewType.html?buildTypeId=DrupalScripts_Build">
<img src="http://ci.viasite.ru/app/rest/builds/buildType:(id:DrupalScripts_Build)/statusIcon"/></a>

# Requirements
- Drush 6.x
- Drupal 7.x

# Install
```
git clone https://github.com/popstas/drupal-scripts.git
cd drupal-scripts
./install.sh
```

It install scripts to `/usr/share/drupal-scripts`.
Config placed to `/etc/drupal-scripts.conf`


## Autocomplete commands
You can add [drupal-scripts.plugin.zsh](drupal-scripts.plugin.zsh) to oh-my-zsh custom plugins or install it with antigen:
```
antigen bundle viasite/drupal-scripts
```

Plugin included in [viasite-ansible.zsh](https://github.com/viasite-ansible/ansible-role-zsh) role.

# Commands docs
See [commands docs](docs/commands.md)
Rebuild docs:
```
./make_markdown_docs
```

# Testing

Run tests in docker environment:
```
cd drupal-scripts
docker run --rm \
 -v $PWD:/usr/local/src/drupal-scripts \
 -w /usr/local/src/drupal-scripts \
 popstas/squeeze bash ./docker-tests.sh
```

You can pass one test through BATS_TESTS variable:
```
export BATS_TESTS="drupal-sql"
./docker-tests.sh
```
or
```
BATS_TESTS=drupal-sql ./docker-tests.sh
```

You can run tests `./run-tests /path/to/drupal/root` in any drupal root directory, it not modifies drupal.

# TODO

## v0.3
- [ ] move todo to github issues
- [ ] global version
- [ ] setup once in tests
- [ ] installer: tests
- [ ] drupal-module-install tests
- [ ] drupal-urls tests
- [ ] drs module-enabled: check directory exists
- [ ] drs module-enabled: multicheck
- [ ] drs modules-undoc: more precise check for undoc
- [ ] bash multi flags
- [ ] bash strict mode
- [ ] drs patch rewrite for relative patches
