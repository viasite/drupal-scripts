#!/usr/bin/env bash

docs_file="docs/scripts.md"
> "$docs_file"

echo "# Drupal scripts docs" >> "$docs_file"

for script in $(ls -1 bin); do
    help=$($script --help | tail -n +3 | sed -e 's/$/  /')
    echo "## $script" >> "$docs_file"
    echo "$help" >> "$docs_file"
    echo "" >> "$docs_file"
    echo "" >> "$docs_file"
done

cat "$docs_file" >&2
