#!/bin/bash

# Colors for better readability
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

function hrzn_pull () {
    function show_help () {
        echo "Pull file from external storage."
        echo "Usage: hrzn.sh [options] <xlnk-file>"
        echo "Options:"
        echo "  -h, --help        Show this help message"
    }
    if [[ $# -eq 0 || "$1" == "-h" || "$1" == "--help" ]]; then
        show_help
        exit 1
    fi

    xlnk_file="$1"
    if [[ ! -f "$xlnk_file" ]]; then
        echo "$RED Linkage file not found:$NC $xlnk_file"
        exit 1
    fi

    while IFS= read -r line; do
        echo "$line"
        if [[ $line == path_x* ]]; then
            path_x=$(echo "$line" | cut -d' ' -f5)
            echo "$YELLOW Retrieving path from linkage file:$NC $path_x"
        elif [[ $line == checksum_x* ]]; then
            checksum_x=$(echo "$line" | cut -d' ' -f5)
        fi
    done < "$xlnk_file"
    if [[ ! -f "$path_x" ]]; then
        echo "$RED File not found in external storage:$NC $path_x"
        exit 1
    fi
    echo "$YELLOW Copying file from external storage...$NC"
    cp -i "$path_x" .
    checksum_local=$(md5sum "$path_x" | cut -d' ' -f1)
    echo "$YELLOW Comparing checksums...$NC"
    echo "Checksum local: $checksum_local"
    echo "Checksum external: $checksum_x"
    if [[ "$checksum_local" == "$checksum_x" ]]; then
        echo "$GREEN File integrity check passed.$NC"
    else
        echo "$RED File integrity check failed.$NC"
        exit 1
    fi
    echo "$GREEN File pulled from external storage:$NC $path_x"
    rm "$path_x"
    echo "$GREEN File removed from external storage:$NC $path_x"
    rm "$xlnk_file"
    echo "$GREEN Linkage file removed:$NC $xlnk_file"
}
