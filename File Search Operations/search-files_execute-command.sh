#!/bin/bash

# Set the directory to search
SEARCH_PATH="/u01/software/test"
SEARCH_DIR="logs"

# Find directories with a name
if (find "$SEARCH_PATH" -type d -name "$SEARCH_DIR"); then
    echo "Directory '${SEARCH_DIR}' exists."

     # find file which are having size below 1MB and copy move them outside
     #Syntax
       # find $folder_under -name "$pattern" -exec "command" {} \; 
     find "${SEARCH_PATH}/${SEARCH_DIR}" -type f -size -1M -exec mv {} "$SEARCH_PATH" \;

else
    echo "Couldn't find a directory with name ${SEARCH_DIR}"
fi
