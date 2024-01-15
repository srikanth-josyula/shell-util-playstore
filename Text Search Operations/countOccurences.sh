#!/bin/bash

# Set the directory to search
SEARCH_PATH="/u01/alfresco/alfresco72/tomcat/logs"

# Find directories with a name
if [ -d "$SEARCH_PATH" ]; then
    echo "Directory '${SEARCH_PATH}' exists."

    SEARCH_ERRORS=$(grep -i -w -c "error" $SEARCH_PATH/*.out);
    echo "Total Count of Word 'ERROR' found: $SEARCH_ERRORS"

else
    echo "Couldn't find a directory with name ${SEARCH_DIR}"
fi
