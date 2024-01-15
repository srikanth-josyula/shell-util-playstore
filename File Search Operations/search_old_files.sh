#!/bin/bash

# Set the directory to search
SEARCH_PATH="/u01/software/test"
SEARCH_DIR="logs"

# Find directories with a name
if (find "$SEARCH_PATH" -type d -name "$SEARCH_DIR"); then
    echo "Directory '${SEARCH_DIR}' exists."

     # find file which are has last modified 7 dayunder the specified directory
     SEARCH_FILES=$(find "${SEARCH_PATH}/${SEARCH_DIR}" -type f -mtime -7)
     printf "Files with command found:\n$SEARCH_FILES\n"

     # find files which are last access 5 min back
     SEARCH_FILES=$(find "${SEARCH_PATH}/${SEARCH_DIR}" -type f -amin -5)
     printf "Files with command found:\n$SEARCH_FILES\n"


        #mmin refers to modified minutes of the files.
        #mtime refers to modified days of the files.
        #amin refers to access minutes of the files.
        #atime refers to the access days of the file.
        #cmin refers to changed minutes of the files.
        #ctime refers to the changed days of the file

else
    echo "Couldn't find a directory with name ${SEARCH_DIR}"
fi
