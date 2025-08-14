#!/bin/bash

# Output to stdout and write to logfile
exec > >(tee -a ./hrzn_move.log) 2>&1


# Colors for better readability
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

function hrzn_move () {
    function show_help () {
        echo "Change the origin path in a verge file."
        echo "Usage: hrzn move [options] <verge-file> <new/origin/path>"
        echo "Options:"
        echo "  -h, --help      Show this help message"
    }
    if [[ $# -eq 0 || "$1" == "-h" || "$1" == "--help" ]]; then
        show_help
        exit 1
    fi
    
    verge_file=$1
    new_origin=$2
    
    # check if linkage file exists
    if [[ ! -f "$verge_file" ]]; then
        echo -e "${RED}Linkage file not found:${NC} $verge_file"
        exit 1
    fi
    
    # search for the origin path in the file
    while IFS= read -r line; do
        if [[ $line == path_o ]]; then
            old_origin=$line
            # ask for confirmation
            echo -e "${YELLOW}Changing origin path from ${NC}$old_origin${YELLOW} to ${NC}$new_origin."
            read -p "Continue? (Y/N): " confirm && [[ $confirm == [yY] || $confirm == [yY][eE][sS] ]] || exit 1
        fi
    done < $verge_file
    # subsitute old filepath for new one if the line starts with path_o
    sed -i path_o/s/\b/$old_origin\b/$new_origin/g $verge_file
    
    # append move action to the file
    {
        echo "date_moved $(date)"
        echo "moved_from $old_origin"
        echo "moved_to $new_origin"
    } >> $verge_file
}