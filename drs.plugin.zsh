#compdef drs

_drs_tables() {
    values=$(drs sql "SHOW TABLES") 2>/dev/null
}

_drs_cache_tables() {
    values=$(drs sql "SHOW TABLES LIKE 'cache_%'") 2>/dev/null
}

_drs_modules() {
    values=$(drs modules-enabled) 2>/dev/null
}

_drs_modules_sites_all() {
    values=$(ls -1 sites/all/modules) 2>/dev/null
}

_drs_variables() {
    values=$(drs sql "SELECT name FROM {variable} ORDER BY name") 2>/dev/null
}

_drs() {
    local -a _1st_arguments
    _1st_arguments=(
        "add-users":"Add users to Drupal in current directory via Drush." \
        "block-timings":"Shows block load time for each block in Drupal." \
        "bootstrap-timings":"Shows Drupal bootstrap load timings." \
        "clear-cache-table":"Cleans cache_ table and optimize it." \
        "cron-add":"Add drupal-cron-run to user system cron." \
        "cron-run":"Run Drush cron in correct environment." \
        "database-settings":"Shows database credentials from settings.php." \
        "decode":"Decode serialized values from Drupal database." \
        "module-doc":"Show module brief module info from custom file with internal documentation." \
        "module-enable-add-git":"Install module, commit module to git." \
        "module-enabled":"Check module status." \
        "modules-enabled":"List enabled modules." \
        "modules-undoc":"List modules without internal documentation." \
        "module-uninstall":"Disable and uninstall module via Drush, then remove module directory with confirmation." \
        "module-version":"Show module version." \
        "patch":"Apply patch." \
        "sql":"Execute sql query." \
        "table-count":"Show count rows from table." \
        "vget":"Show Drupal variable."
    )

    _arguments \
        '*:: :->commands' && return 0

    if (( CURRENT == 1 )); then
        _describe -t commands "drs commands" _1st_arguments
        return
    fi

    case "$words[1]" in
        clear-cache-table)
        _drs_cache_tables
        compadd "$@" $(echo $values)
        ;;

        database-settings)
        compadd "$@" 'database' 'username' 'password' 'prefix' 'host' 'port'
        ;;

        module-doc)
        _drs_modules
        compadd "$@" $(echo $values)
        ;;

        module-uninstall)
        _drs_modules_sites_all
        compadd "$@" $(echo $values)
        ;;

        table-count)
        _drs_tables
        compadd "$@" $(echo $values)
        ;;
        
        vget)
        _drs_variables
        compadd "$@" $(echo $values)
        ;;
    esac
}

compdef _drs drs
