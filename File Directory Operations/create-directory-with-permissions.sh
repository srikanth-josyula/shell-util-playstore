#!/bin/bash

# Script for Setting Permissions during Creation

PERMISSIONS_DIR='permissions_directory'

# Check if the directory already exists
if [ -d "$PERMISSIONS_DIR" ]; then
    echo "Directory '$PERMISSIONS_DIR' already exists."
else
    # Create directory with specific permissions
    mkdir -m 755 "$PERMISSIONS_DIR" && echo "Directory '$PERMISSIONS_DIR' created with permissions 755." || echo "Failed to create directory."
fi
