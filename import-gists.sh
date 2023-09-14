#!/bin/bash
set -e

INTERMEDIATE_DIR=$(dirname $0)/intermediate
EXPORTED_DIR=$INTERMEDIATE_DIR/gists/export
IMPORT_DIR=$INTERMEDIATE_DIR/gists/import

# Ensure import dir is clean present
rm $IMPORT_DIR/*
mkdir -p $IMPORT_DIR

# List files from the detail dir
for file in "${EXPORTED_DIR}"/*
do
    description=$(head -n 1 $file)
    new_file=$IMPORT_DIR/$(basename -- $file)
    # Remove first two lines because they contain the descripton and a blank line
    sed -e "1,2d" $file > $new_file
    echo "Creating gist from file '${file}' with description '${description}'"
    # Using filename (id) create new gist
    gh gist create $new_file -d "${description}" --public
done
