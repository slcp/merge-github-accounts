#!/bin/bash
set -e

TEMP_DIR=$(dirname $0)/intermediate
NEW_OWNER="slcp"

# Create an intermediate artifacts directory
mkdir -p $TEMP_DIR

# Get repositories list
gh repo list --limit 200 --json 'name,nameWithOwner,url' > $TEMP_DIR/repos.json

jq -c -r '.[].nameWithOwner' $TEMP_DIR/repos.json > $TEMP_DIR/repo-urls.txt

cat $TEMP_DIR/repo-urls.txt | xargs -L1 -I urlpart gh api repos/urlpart/transfer -f new_owner=$NEW_OWNER
