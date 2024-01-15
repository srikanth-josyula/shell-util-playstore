#!/bin/bash

# Set the Tomcat logs folder
tomcat_logs_folder="/path/to/tomcat/logs"

# Example 1: Find and grep for a specific pattern, displaying matching lines
echo "Example 1:"
find "$tomcat_logs_folder" -type f -name "*.log" -exec grep -i "your_pattern" {} +

# Example 2: Count the occurrences of a pattern in Tomcat logs
echo "Example 2:"
count=$(find "$tomcat_logs_folder" -type f -name "*.log" -exec grep -c "your_pattern" {} +)
echo "Count of occurrences: $count"

# Example 3: Search for whole words in Tomcat logs, displaying matching lines
echo "Example 3:"
find "$tomcat_logs_folder" -type f -name "*.log" -exec grep -w "your_pattern" {} +

# Example 4: Display only the names of files with matching lines
echo "Example 4:"
find "$tomcat_logs_folder" -type f -name "*.log" -exec grep -l "your_pattern" {} +

# Example 5: Search for multiple patterns in Tomcat logs, displaying matching lines
echo "Example 5:"
find "$tomcat_logs_folder" -type f -name "*.log" -exec grep -e "pattern1" -e "pattern2" {} +
