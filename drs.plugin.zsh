#compdef drs

_drs() {
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
}

compdef _drs drs
