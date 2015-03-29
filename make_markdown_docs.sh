#!/usr/bin/env bash

temp_file="README.md.tmp"
> "$temp_file"

for script in $(ls -1 bin); do
    help=$($script --help | tail -n +3 | sed -e 's/$/  /')
    echo "## $script" >> "$temp_file"
    echo "$help" >> "$temp_file"
    echo "" >> "$temp_file"
    echo "" >> "$temp_file"
done

cat "$temp_file"
