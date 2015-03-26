# drupal-scripts

Shell scripts for Drupal.

All scripts should run from drupal site root_path.

Some scripts expects that contrib modules place in sites/all/modules

# Requirements
- Drush
- Drupal 7.x

# Install
sh install.sh /usr/local

# TODO
- [x] move shared code to drupal-scripts-init
- [ ] replace $(basename $PWD) to get_domain
- [ ] write docs
- [ ] write tests
