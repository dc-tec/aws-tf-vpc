#!/bin/bash

# Function to process the .tf files in the current directory
process_tf_files() {
  # Run terraform fmt to format .tf files in the current directory
  echo "Formatting files in: $PWD"
  /usr/local/bin/terraform fmt --recursive
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

echo "Formatting Terraform files..."
echo "============================="

# Start the traversal from the root directory
traverse_directories "."

echo "============================="
echo "Terraform files formatting complete!"