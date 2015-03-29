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

# Scripts

## drupal-add-users
Add users to Drupal in current directory via Drush.  
  
Usage: drupal-add-users email [role=] [password=random]  
        - add new user with login=email, defined role and password  
  
       drupal-add-users all [path/to/file]  
        - add all users from file or from USERS_LIST_FILE in config,  
          file in format:  
          email [role] [password]  


## drupal-block-timings
Shows block load time for each block in Drupal.  
Columns: block,time,theme,region  


## drupal-bootstrap-timings
Shows Drupal bootstrap load timings.  
Each time shows bootstrap from previous level.  


## drupal-clear-cache-table
Cleans cache_ table and optimize it.  
Delete only expired cache.  
  
Usage: drupal-clear-cache-table cache_table_name  


## drupal-cron-add
Add drupal-cron-run to user system cron.  
  
Cron job runs in random minute every 3 hours.  
Cron job add to user-owner of root_path.  
  
Options:  
        -s Simulate mode, don't actually change the system  


## drupal-cron-run
Run Drush cron in correct environment.  
  
Usage: drupal-cron-run root_path  
        - run drush cron in root_path  
       drupal-cron-run root_path elysia-cron  
        - run drush elysia-cron in root_path  
       drupal-cron-run root_path cron domain  
        - run drush cron in root_path using domain.  
          Need for override http://default.  
          Default domain - basename of root_path  


## drupal-database-settings
Shows database credentials from settings.php.  
  
Usage: drupal-database-settings (database|username|password|prefix)  


## drupal-decode
Decode serialized values from Drupal database.  
  
Usage: drupal-decode "serialized_string"  
       echo "serialized_string" | drupal-decode  


## drupal-disable-rm
Disable module via Drush and remove module directory.  


## drupal-module-doc
Show module brief module info from custom file with internal documentation.  


## drupal-module-enable-add-git
Install module, commit module to git.  
  
Usage: drupal-module-enable-add-git module_name  


## drupal-module-enabled
Check module status.  
Same as drush pml --status=enabled --type=module, but faster.  
Outputs 1 or 0.  


## drupal-modules-enabled
List enabled modules.  
Same as drush pml --status=enabled --type=module --pipe,  
but faster and with 10 minute cache  


## drupal-modules-undoc
List modules without internal documentation.  


## drupal-module-version
Show module version.  


## drupal-patch
Apply patch.  
  
Usage: drupal-patch (path_file|path_url)  


## drupal-scripts-init
Include file for all scripts. Not used independently.  


## drupal-sql
Execute sql query.  
Same as drush sql-query, but faster.  
  
Usage: drupal-sql "query"  
  
Table names must be encapsulated in {}  


## drupal-table-count
Show count rows from table.  
Same as drupal-sql "SELECT COUNT(*) FROM {table_name}".  
  
Usage: drupal-table-count table_name  


## drupal-vget
  
Show Drupal variable.  
Same as drush vget, but faster.  
  
Usage: drupal-vget var_name  







# TODO
- [x] move shared code to drupal-scripts-init
- [ ] rewrite drupal scripts root in conf.example
- [ ] replace $(basename $PWD) to get_domain
- [ ] write docs
- [ ] write tests
