#!/bin/bash

# Set the directory to search
search_path="/path/to/search"

# Find files with a specific name pattern
find "$search_path" -name "pattern"

# Find directories
find "$search_path" -type d

# Find files of a specific size (e.g., greater than 10M)
find "$search_path" -type f -size +10M

# Execute a command on each found file or directory (replace "your_command" with the actual command)
find "$search_path" -type f -exec your_command {} \;

# Print the path of each found file or directory
find "$search_path" -print

# Find files modified within the last 7 days
find "$search_path" -type f -mtime -7

# Find files owned by a specific user (replace "username" with the actual username)
find "$search_path" -type f -user username

# Find files belonging to a specific group (replace "groupname" with the actual group name)
find "$search_path" -type f -group groupname
