#!/bin/bash
set -e

OLD_IFS=$IFS
INTERMEDIATE_DIR=$(dirname $0)/intermediate
TEMP_DIR=$INTERMEDIATE_DIR/gists/export
GIST_LIST_FILE=$INTERMEDIATE_DIR/gists.txt

function reset_ifs {
    IFS=$OLD_IFS
}

# Clean and create an intermediate artifacts directory
rm -rf $TEMP_DIR
mkdir -p $TEMP_DIR

# Get gists list
gh gist list --limit 200 > $GIST_LIST_FILE

while read -r line
do
    # TODO: Should be able to do all of this with regex but couldn't get it to mactch on the tab character for grouping
    IFS='	'
    # Why does this replace the weird tab character with a space?
    read -a nicer_formatted_line <<< $line
    IFS=' '
    read -r id rest <<< $nicer_formatted_line[0]
    regex='(.*) 1 file (.*)'
    reset_ifs

    # [[ $nicer_formatted_line =~ $regex ]] 
    # description=${BASH_REMATCH[1]}

    GIST_DETAIL_FILE="${TEMP_DIR}/${id}"

    # Export the gist
    gh gist view $id > $GIST_DETAIL_FILE
done < $GIST_LIST_FILE