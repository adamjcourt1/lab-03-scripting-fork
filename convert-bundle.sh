#!/bin/bash
set -euo pipefail

URL="https://s3.amazonaws.com/ds2002-resources/labs/lab3-bundle.tar.gz"

# fetch the tarball
curl -fsSL -o lab3-bundle.tar.gz "$URL"

# extract it
tar -xzf lab3-bundle.tar.gz

# locate the TSV file inside the extracted contents
TSV_FILE=$(find . -type f -name '*.tsv' -print -quit)
echo "Found dataset: $TSV_FILE"

# remove empty rows, write to a new file
awk '!/^[[:space:]]*$/' "$TSV_FILE" > cleaned.tsv

# convert tabs to commas
tr '\t' ',' < cleaned.tsv > cleaned.csv

# count rows and print
DATA_ROWS=$(awk 'END { print NR - 1 }' cleaned.csv)
echo "Data rows remaining: $DATA_ROWS"

# package the cleaned csv
tar -czf converted-archive.tar.gz cleaned.csv
echo "Created converted-archive.tar.gz"