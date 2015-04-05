#!/usr/bin/env bash

docs_file="docs/commands.md"
> "$docs_file"

drs --help >> "$docs_file"
echo "" >> "$docs_file"

echo "# drs commands" >> "$docs_file"
echo "" >> "$docs_file"

for line in $(drs help | cut -d' ' -f1); do
	cmd=$(echo "$line" | cut -d' ' -f1)
	help=$(drs help "$cmd" | tail -n +3 | sed -e 's/$/  /')
	echo "## drs $cmd" >> "$docs_file"
	echo "$help" >> "$docs_file"
	echo "" >> "$docs_file"
	echo "" >> "$docs_file"
done

cat "$docs_file" >&2
