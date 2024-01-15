#!/bin/bash

# Set the directory to search
SEARCH_PATH="/u01/software/test"
SEARCH_DIR="logs"

# Find directories with a name
if (find "$SEARCH_PATH" -type d -name "$SEARCH_DIR"); then
    echo "Directory '${SEARCH_DIR}' exists."

     # file [options] filename syntax
     find "${SEARCH_PATH}/${SEARCH_DIR}" -type f -name '*' -exec file -i {} \;

else
    echo "Couldn't find a directory with name ${SEARCH_DIR}"
fi
