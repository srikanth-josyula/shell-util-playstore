SEARCH_PATH="/u01/software/test"
SEARCH_DIR="logs"

# Find directories with a name
if (find "$SEARCH_PATH" -type d -name "$SEARCH_DIR"); then
    echo "Directory '${SEARCH_DIR}' exists."

     # find file which are having size below than 5MB
     find "${SEARCH_PATH}/${SEARCH_DIR}" -type f -user alfcad05;

     # find file which are having size below than 5MB
     find "${SEARCH_PATH}/${SEARCH_DIR}" -type f -group alfcad05;

     # find file which are having size below than 5MB
     find "${SEARCH_PATH}/${SEARCH_DIR}" -type f -perm 777;


else
    echo "Couldn't find a directory with name ${SEARCH_DIR}"
fi
