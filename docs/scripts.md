# Drupal scripts docs
## drupal-add-users
Add users to Drupal in current directory via Drush.  
If password not defined, it will be generated.  
login=email  
  
Usage: drupal-add-users email  
        - add new user with login=email and role from USERS_DEFAULT_ROLE in config  
  
       drupal-add-users email [role=] [password=random]  
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
          Need for override http://default, for simplenews.  
          Default domain - basename of root_path  


## drupal-database-settings
Shows database credentials from settings.php.  
  
Usage: drupal-database-settings (database|username|password|prefix|host|port)  


## drupal-decode
Decode serialized values from Drupal database.  
Can decode variables and arrays.  
true decodes as 1 and false as 0.  
Arrays decodes as print_r.  
  
Usage: drupal-decode "serialized_string"  
       echo "serialized_string" | drupal-decode  


## drupal-module-doc
Show module brief module info from custom file with internal documentation.  
  
Usage: drupal-module-doc  
        - output whole docs file  
  
       drupal-module-doc module_name  
        - output lines about module  


## drupal-module-enable-add-git
Install module, commit module to git.  
  
Usage: drupal-module-enable-add-git module_name [git_comment]  


## drupal-module-enabled
Check module status.  
Same as drush pml --status=enabled --type=module, but faster.  
Outputs 1 or 0.  
  
Options:  
    -f Force check module, without cache  


## drupal-modules-enabled
List enabled modules.  
Same as drush pml --status=enabled --type=module --pipe,  
but faster and with cache.  
Cache time defines in minutes, from MODULES_CACHE_TIME in config, default 10 minutes.  
  
Options:  
    -f Force check module, without cache  


## drupal-modules-undoc
List modules without internal documentation.  


## drupal-module-uninstall
Disable and uninstall module via Drush, then remove module directory with confirmation.  
Working only for modules in sites/all  
  
Usage: drupal-module-uninstall module_name  
  
Options:  
    -y Assume yes on delete directory confirmation  
    -n Assume no on delete directory confirmation  


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
  
Table names must be encapsulated in {} if db has prefixes, ex.  
SELECT COUNT(*) FROM {node}  
  
Output "error" if error occured.  
  
Options:  
    -v Verbose mode, output sql and connection parameters, explain sql errors  


## drupal-table-count
Show count rows from table.  
Same as drupal-sql "SELECT COUNT(*) FROM {table_name}".  
  
Usage: drupal-table-count table_name  
  
Output 0 if error occured.  


## drupal-vget
  
Show Drupal variable.  
Same as drush vget, but faster.  
  
Usage: drupal-vget var_name  


