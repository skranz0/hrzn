#!/bin/bash

# This is to be used in case the path of the external storage changes.
# It searches for verge files recursively and changes the path_x field

# Colors for better readability
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

function change-external () {
    echo -e "${YELLOW}Searching verge files...${NC}"
    VERGE_FILES=$(find . -type f -name "*verge")
    echo -e "${YELLOW}The following files will be changed:${NC}"
    echo $VERGE_FILES
    echo "Continue?"
    select continue in "Yes" "No"; do
        case $continue in
            Yes ) $(read -p "Enter new path: " NEW_PATH); break;;
            No ) exit;;
        esac
    done

    function change_path () {
        local file=$1

        echo -e "${YELLOW}Changing external path for $file."
        # search for the external path in the file
        while IFS= read -r line; do
            if [[ $line == path_x ]]; then
                old_external=$line
            fi
        done < $file
        # subsitute old filepath for new one if the line starts with path_x
        sed -i path_x/s/\b/$old_external\b/$NEW_PATH/g $file

        # append move action to the file
        {
            echo "date_external_changed $(date)"
            echo "changed_from $old_external"
            echo "moved_to $NEW_PATH"
        } >> $verge_file
    }

    parallel change_path ::: $VERGE_FILES
}
