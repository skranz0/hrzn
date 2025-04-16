#!/bin/bash


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
        echo "File not found: $file"
        exit 1
    fi

    # copy file to external storage
    echo "Copying file to external storage..."
    cp -i "$file" "$external_storage"
    # calculate and compare checksums
    echo "Calculating checksums..."
    checksum_origin=$(md5sum "$file" | cut -d' ' -f1)
    checksum_external=$(md5sum "$external_storage""$file" | cut -d' ' -f1)
    echo "Checksum origin: $checksum_origin"
    echo "Checksum external: $checksum_external"
    if [[ "$checksum_origin" == "$checksum_external" ]]; then
        echo "File integrity check passed."
    else
        echo "File integrity check failed."
        exit 1
    fi

    # create link file
    echo "Creating linkage file..."
    touch "$file.verge"
    {
        echo "path_o    $(pwd)/$file";
        echo "path_x    $external_storage$file";
        echo "checksum_o    $checksum_origin";
        echo "checksum_x    $checksum_external";
    } >> "$file.verge"    
    echo "linkage file created: $file.verge"
    echo "File pushed to external storage: '$external_storage$file'"

    rm "$file"
    echo "Original file removed"
}