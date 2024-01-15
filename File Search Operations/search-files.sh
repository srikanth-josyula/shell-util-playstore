SEARCH_PATH="/u01/software/test"
SEARCH_DIR="logs"

# Find directories with a name
if (find "$SEARCH_PATH" -type d -name "$SEARCH_DIR"); then
    echo "Directory '${SEARCH_DIR}' exists."

     # find file under the specified directory with format
     SEARCH_FILES=$(find "${SEARCH_PATH}/${SEARCH_DIR}" -type f -name "*.out")
     echo "Files with command found: $SEARCH_FILES"

     # consider Case-insensitive version of `-name`. Searches for files with a specific name or pattern, regardless of case.
     SEARCH_FILES1=$(find "${SEARCH_PATH}/${SEARCH_DIR}" -type f -iname "*.out")
     echo "Files with command found: $SEARCH_FILES1"
else
    echo "Couldn't find a directory with name ${SEARCH_DIR}"
fi
