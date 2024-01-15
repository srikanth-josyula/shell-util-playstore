SEARCH_PATH="/u01/software/test"
SEARCH_DIR="logs"

# Find directories with a name
if (find "$SEARCH_PATH" -type d -name "$SEARCH_DIR"); then
    echo "Directory '${SEARCH_DIR}' exists."

     # find file which are having size below than 5MB
     SEARCH_FILES=$(find "${SEARCH_PATH}/${SEARCH_DIR}" -type f -size -5M)
     printf "Files with command found:\n$SEARCH_FILES\n"

     # find file which are having size more than 5MB
     SEARCH_FILES1=$(find "${SEARCH_PATH}/${SEARCH_DIR}" -type f -size +5M)
     printf "Files with command found:\n$SEARCH_FILES1\n"
     

else
    echo "Couldn't find a directory with name ${SEARCH_DIR}"
fi
