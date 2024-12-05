#!/bin/bash

# Check if the script received exactly one argument
if [ "$#" -ne 1 ]; then
  read -p "Enter new personal access token: " token
else
  token=$1
fi

# Variables
new_pat=$token
netrc_file="$HOME/.netrc"
machine="DEFAULT_MACHINE"
login="DEFAULT_USER"

# Check if the .netrc file exists
if [ ! -f "$netrc_file" ]; then
  echo "Error: .netrc file not found at $netrc_file"
  exit 1
fi

# Define the PAT regex pattern
pat_regex='^pat\.DEFAULT_ACCOUNT\.[a-zA-Z0-9]+(\.[a-zA-Z0-9]+)+$'

# Check if the provided PAT matches the expected format
if [[ ! $new_pat =~ $pat_regex ]]; then
  echo "Error: The provided PAT does not match the expected format."
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
  if (updated == 1) {
    exit 0
  } else {
    exit 1
  }
}
' "$netrc_file" > "${netrc_file}.tmp" && mv "${netrc_file}.tmp" "$netrc_file"

# Check if the update was successful and print the appropriate message
if [ $? -eq 0 ]; then
  echo "Updated .netrc with new PAT."
else
  echo "No matching machine and login found in .netrc."
fi
