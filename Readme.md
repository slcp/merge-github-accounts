# Some possibly useful scripts to help you merge two Github accounts

All of the scripts contained use the [Github ClI](https://cli.github.com/), please make sure it is installed and it is logged into the correct account for each step. See below for more info.

## Migrate - `migrate-repos.sh`

The ownership of repositories can be transferred from one account to another ([more info](https://docs.github.com/en/repositories/creating-and-managing-repositories/transferring-a-repository)). Ensure that you have read all the information about this operation as there are some limitations depending on the kinds of accounts involved.

This is a script automate the transfer of ownership requests for all the repositories in a source account to a target account.

IMPORTANT: The Github CLI should be logged into the **source** account, this means the account that you are looking to move away from and stop using.
IMPORTANT: This is not a destructive operation but testing this on a single test repo would be prudent as there is some clean up in your emails to do if the results are not as desired.

PREPARATION: Ensure that the `NEW_OWNER` variable in `migrate-repos.sh` is set the username of the target account.

Run the script and then the owner of the target account should have an email for each transfer request from which they can accept the transfer.

## Gists

The ownership of gists cannot be transferred between accounts unfortunately but the approach I took was to recreate all the gists from the source account in the target account. The original gists are left intact as they well may be in use by third parties, if the source account is deleted the links any third party has will no longer work - I'm not aware of way around that. Moving the gists in this way was useful for my own reference and for having everything in one place.

It is a two step process:

### Export Gists - `export-gists.sh`

This is a script automate the export of gists from the source account.

IMPORTANT: The Github CLI should be logged into the **source** account, this means the account that you are looking to move away from and stop using.
IMPORTANT: This is not a destructive operation and only exports gists to the local disk.

Run the script and you will see the exported gists in `./intermediate/gists/export`.

### Import Gists

This is a script automate the import of gists into the target account.

IMPORTANT: The Github CLI should be logged into the **target** account, this means the account that you are looking to move assets to.
IMPORTANT: This is not a destructive operation but will create new gists in the target account in bulk so testing on individual gists may be prudent.

PREPARATION: Ensure that `export-gists.sh` has been run.
PREPARATION: Ensure that each file in `./intermediate/gists/export` has a description line at the top followed by a blank line. The script assumes the exported gist had a description on the first line and will remove the first two lines to get the original content. Any gist that did not have a description originally should be prepared in this way.

Run the script and new gists will be prepared in `./intermediate/gists/import` as above, they will also be created in the target account