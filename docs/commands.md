drs v0.2.0

Drupal script wrapper.

Usage:

       drs command [options]
        - execute command

       drs help
        - list all commands

       drs help command
        - show command help

# drs commands

## drs add-users
Add users to Drupal in current directory via Drush.  
If password not defined, it will be generated.  
login=email  
  
Usage:  
  
       drs add-users email  
        - add new user with login=email and role from USERS_DEFAULT_ROLE in config  
  
       drs add-users email [role=] [password=random]  
        - add new user with login=email, defined role and password  
  
       drs add-users all [path/to/file]  
        - add all users from file or from USERS_LIST_FILE in config,  
          file in format:  
          email [role] [password]  
          allowed comment lines begins from #  
  


## drs block-timings
Shows block load time for each block in Drupal.  
Columns: block,time,theme,region  


## drs bootstrap-timings
Shows Drupal bootstrap load timings.  
Each time shows bootstrap from previous level.  


## drs clear-cache-table
Cleans cache_ table and optimize it.  
Delete only expired cache.  
  
Usage:  
       drs clear-cache-table cache_table_name  
  
Options:  
       -v Verbose mode  


## drs cron-add
Add drupal-cron-run to user system cron.  
  
Cron job runs in random minute every 3 hours.  
Cron job add to user-owner of root_path.  
  
Options:  
        -s Simulate mode, don't actually change the system  


## drs cron-run
Run Drush cron in correct environment.  
  
Usage:  
  
       drs cron-run root_path  
        - run drush cron in root_path  
  
       drs cron-run root_path elysia-cron  
        - run drush elysia-cron in root_path  
  
       drs cron-run root_path cron domain  
        - run drush cron in root_path using domain.  
          Need for override http://default, for simplenews.  
          Default domain - basename of root_path  


## drs database-settings
Shows database credentials from settings.php.  
  
Usage:  
       drs database-settings (database|username|password|prefix|host|port)  


## drs decode
Decode serialized values from Drupal database.  
Can decode variables and arrays.  
true decodes as 1 and false as 0.  
Arrays decodes as print_r.  
  
Usage:  
  
       drs decode "serialized_string"  
  
       echo "serialized_string" | drs decode  


## drs module-doc
Show module brief module info from custom file with internal documentation.  
  
Usage:  
  
       drs module-doc  
        - output whole docs file  
  
       drs module-doc module_name  
        - output lines about module  
  
       drs module-doc module_name docs_file  
        - output lines about module from docs_file  


## drs module-enable-add-git
Install module, commit module to git.  
  
Usage:  
       drs module-enable-add-git module_name [git_comment]  


## drs module-enabled
Check module status.  
Same as drush pml --status=enabled --type=module, but faster.  
Outputs 1 or 0.  
  
Options:  
    -f Force check module, without cache  


## drs module-install
Copy module from directory.  
  
Usage:  
       drs module-install /path/to/module_dir [module_name]  
  
Options:  
       -f Remove exists module  
       -y Assume yes  
  


## drs modules-enabled
List enabled modules.  
Same as drush pml --status=enabled --type=module --pipe,  
but faster and with cache.  
Cache time defines in minutes, from MODULES_CACHE_TIME in config, default 10 minutes.  
  
Options:  
    -f Force check module, without cache  


## drs modules-undoc
List modules without internal documentation.  


## drs module-uninstall
Disable and uninstall module via Drush, then remove module directory with confirmation.  
Working only for modules in sites/all  
  
Usage:  
       drs module-uninstall module_name  
  
Options:  
       -y Assume yes on delete directory confirmation  
       -n Assume no on delete directory confirmation  


## drs module-version
Show module version.  


## drs patch
Apply patch.  
  
Usage:  
       drs patch (path_file|path_url)  


## drs patch-add
Add patch to /patches/ directory.  
  
Usage:  
       drs patch-add (path_file|path_url)  


## drs sql
Execute sql query.  
Same as drush sql-query, but faster.  
  
Usage:  
       drs sql "query"  
  
Table names must be encapsulated in {} if db has prefixes, ex.  
SELECT COUNT(*) FROM {node}  
  
Output "error" if error occured.  
  
Options:  
    -v Verbose mode, output sql and connection parameters, explain sql errors  


## drs table-count
Show count rows from table.  
Same as drupal-sql "SELECT COUNT(*) FROM {table_name}".  
  
Usage:  
       drs table-count table_name  
  
Output 0 if error occured.  


## drs urls
Get urls of site.  
  
Usage:  
       drs urls [url_type]  
  
url_type - one of: sitemap mainpage node  
  
Проходит по всем друпалам, где есть sitemap, прогревает каждую ссылку из карты.  
Там, где карты нет, прогревает главку.  
  
Выбирает с помощью drall, берет только сайты с включенным кешем анонимов.  
  
Также проверяет, включен ли модуль xmlsitemap.  
Если sitemap.xml содержит ссылки на другие sitemap.xml, они будут обработаны рекурсивно.  
  
На выходе выдает cached_sites / scanned_sites  
  
Options:  
    -v Verbose mode  
    -q Quiet mode  


## drs vget
Show Drupal variable.  
Same as drush vget, but faster.  
  
Usage:  
       drs vget var_name  
  
Options:  
    -v Verbose mode  


