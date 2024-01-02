#!/bin/bash

# Shell Script for Creating Directories
DIR_NAME='testing'

# Check if the directory already exists
if [ -d "$DIR_NAME" ]; then
    echo "Directory '${DIR_NAME}' already exists."
else
    # Create a new directory under the current folder
    mkdir "$DIR_NAME"
    echo "A new directory with name '${DIR_NAME}' is created."
fi

# List the contents of the current directory
ls -ltr
