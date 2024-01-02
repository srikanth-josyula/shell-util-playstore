#!/bin/bash

# Shell Script for Creating Directories
NESTED_DIR='parent/child/grandchild'

# Check if the directory already exists
if [ -d "$NESTED_DIR" ]; then
    echo "Directory '$NESTED_DIR' already exists."
else
    # Create nested directories
    mkdir -p "$NESTED_DIR" && echo "Nested Directories created successfully." || echo "Failed to create nested directories."
fi

# List the contents of the current directory
ls -ltr
