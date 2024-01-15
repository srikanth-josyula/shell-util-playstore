#!/bin/bash

# Set the directory to search
SEARCH_PATH="/u01/software/test"
SEARCH_DIR="logs"

# Find directories with a name
if (find "$SEARCH_PATH" -type d -name "$SEARCH_DIR"); then
    echo "Directory '${SEARCH_DIR}' exists."

     # find empty file under the specified directory
     SEARCH_FILES=$(find "${SEARCH_PATH}/${SEARCH_DIR}" -type f -empty)
     printf "Files with command found:\n$SEARCH_FILES\n"

else
    echo "Couldn't find a directory with name ${SEARCH_DIR}"
fi
