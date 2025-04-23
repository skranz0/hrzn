#!/bin/bash

# Output to stdout and write to logfile
exec > >(tee -a ./hrzn_push.log) 2>&1


# Colors for better readability
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

# import config with path to external storage
external_storage=""
source "/etc/hrzn/config"

# function definitions
function hrzn_push () {
    function show_help () {
        echo "Push file to external storage and create linkage file."
        echo "Usage: hrzn.sh [options] <file>"
        echo "Options:"
        echo "  -h, --help        Show this help message"

    }
    if [[ $# -eq 0 || "$1" == "-h" || "$1" == "--help" ]]; then
        show_help
        exit 1
    fi

    file="$1"
    # check if file exists
    if [[ ! -f "$file" ]]; then
        echo "$RED File not found: $file $NC"
        exit 1
    fi

    # copy file to external storage
    echo "$YELLOW Copying file to external storage...$NC"
    cp -i "$file" "$external_storage"
    # calculate and compare checksums
    echo "$YELLOW Calculating checksums...$NC"
    checksum_origin=$(md5sum "$file" | cut -d' ' -f1)
    checksum_external=$(md5sum "$external_storage""$file" | cut -d' ' -f1)
    echo "Checksum origin: $checksum_origin"
    echo "Checksum external: $checksum_external"
    if [[ "$checksum_origin" == "$checksum_external" ]]; then
        echo "$GREEN File integrity check passed.$NC"
    else
        echo "$RED File integrity check failed.$NC"
        exit 1
    fi

    # create link file
    echo "$YELLOW Creating linkage file...$NC"
    touch "$file.verge"
    {
        echo "path_o    $(pwd)/$file";
        echo "path_x    $external_storage$file";
        echo "checksum_o    $checksum_origin";
        echo "checksum_x    $checksum_external";
    } >> "$file.verge"
    echo "$GREEN Linkage file created:$NC $file.verge"
    echo "$GREEN File pushed to external storage:$NC '$external_storage$file'"

    rm "$file"
    echo "$GREEN Original file removed$NC"
}
