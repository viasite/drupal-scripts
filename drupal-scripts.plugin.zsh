#compdef drs

_drs_add_users() {
    source /etc/drupal-scripts.conf
    values="$(cat "$USERS_LIST_FILE" | grep -v "^#" | awk '{ print $1 }')"
}

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
    IFS=$'
'
    _1st_arguments=($(drs help | perl -pe 's|(.*?)\s+(.*)|\1:$2 \\|'))

    _arguments \
        '*:: :->commands' && return 0

    if (( CURRENT == 1 )); then
        _describe -t commands "drs commands" _1st_arguments
        return
    fi

    case "$words[1]" in
        add-users)
        _drs_add_users
        compadd "$@" $(echo $values)
        ;;

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
