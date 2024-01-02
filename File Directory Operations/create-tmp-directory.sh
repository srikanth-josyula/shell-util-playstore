#!/bin/bash

# Script for Creating a Simple Temporary Directory

# Create a simple temporary directory
TEMP_DIR=$(mktemp -d) && echo "Temporary Directory created: $TEMP_DIR" || echo "Failed to create temporary directory."

# With a Custom NAME
# Create a simple temporary directory
TEMP_DIR=$(mktemp -d  --suffix SRIKANTH TEST-XXXXXX) && echo "Temporary Directory created: $TEMP_DIR" || echo "Failed to create temporary directory."
#output
#TEST-PuVQlU-SRIKANTH
