#!/bin/bash

# Function to recursively rename files and directories starting with " - "
rename_files_and_dirs_with_space_hyphen_space() {
    local target_dir="$1"

    # Find files and directories starting with " - " and rename them
    find "$target_dir" -depth -name ' - *' | while read -r path; do
        # Get the directory and base name
        dir=$(dirname "$path")
        base=$(basename "$path")

        # Replace " - " with "_"
        new_name="${base// - /_}"
        new_path="$dir/$new_name"

        if [[ -e "$new_path" ]]; then
            echo "Warning: '$new_path' already exists. Skipping renaming '$path'."
        else
            mv "$path" "$new_path"
            echo "Renamed '$path' to '$new_path'."
        fi
    done
}

# Usage: ./rename_space-space_to_underscore.sh /path/to/target_directory
if [[ $# -eq 1 ]]; then
    target_directory="$1"

    if [[ ! -d "$target_directory" ]]; then
        echo "Error: '$target_directory' is not a valid directory."
        exit 1
    fi

    rename_files_and_dirs_with_space_hyphen_space "$target_directory"
else
    echo "Usage: $0 /path/to/target_directory"
fi
