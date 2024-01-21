#!/bin/bash

# Function to process the .tf files in the current directory
process_tf_files() {
  # Run the terraform-docs command in the current directory
  /usr/local/terraform-docs markdown table --output-file README.md --output-mode inject .
}

# Function to traverse directories recursively
traverse_directories() {
  for entry in "$1"/*; do
    if [[ -d "$entry" ]]; then
      # If the entry is a directory, recursively call the function
      traverse_directories "$entry"
    elif [[ -f "$entry" && "$entry" == *.tf ]]; then
      # If the entry is a .tf file, process it in its parent directory
      cd "$(dirname "$entry")" || exit 1
      process_tf_files
      cd - || exit 1 # Return to the previous directory
    fi
  done
}

# Start the traversal from the root directory
traverse_directories "."

echo "Terraform documentation update complete!"
