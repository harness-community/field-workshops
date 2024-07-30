#!/bin/bash

# Check if the script received exactly one argument
if [ "$#" -ne 1 ]; then
  echo "Usage: $0 <new_personal_access_token>"
  exit 1
fi

# Variables
new_pat=$1
netrc_file="$HOME/.netrc"
machine="DEFAULT_MACHINE"
login="DEFAULT_USER"

# Check if the .netrc file exists
if [ ! -f "$netrc_file" ]; then
  echo "Error: .netrc file not found at $netrc_file"
  exit 1
fi

# Update the .netrc file with the new PAT
awk -v machine="$machine" -v login="$login" -v new_pat="$new_pat" '
BEGIN { machine_found=0; login_found=0; updated=0; }
/^machine/ {
  if ($2 == machine) { machine_found=1; }
}
/^login/ {
  if (machine_found && $2 == login) { login_found=1; }
}
/^password/ {
  if (machine_found && login_found) {
    $2 = new_pat;
    updated=1;
  }
}
{ print; }
END {
  if (updated) {
    print "Updated .netrc with new PAT.";
  } else {
    print "No matching machine and login found in .netrc.";
  }
}
' "$netrc_file" > "${netrc_file}.tmp" && mv "${netrc_file}.tmp" "$netrc_file"
