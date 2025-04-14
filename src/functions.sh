#!/bin/bash

# create exchange link file
function create_xlnk () {
    echo "Creating exchange link file..."
}

function hrzn_push () {
    function show_help () {
        echo "Push file to external storage and create linkage file."
        echo "Usage: hrzn.sh [options] <file>"
        echo "Options:"
        echo "  -h, --help        Show this help message"
        
    }

    if [[ $# -eq 0 ]]; then
        show_help
        exit 1
    fi

    file="$1"

    cp "$file" /external_storage/xchange_horizon/ # TODO read external storage path from config
    checksum_origin=$(md5sum "$file")
    checksum_external=$(md5sum /external_storage/xchange_horizon/"$file")
    if [[ "$checksum_origin" == "$checksum_external" ]]; then
        echo "File integrity check passed."
    else
        echo "File integrity check failed."
        exit 1
    fi

    # create link file
    touch "$file.xlink"
    {
        echo "path_o    $(pwd)'$file'";
        echo "path_x    /external_storage/xchange_horizon/$file";
        echo "checksum_o    $checksum_origin";
        echo "checksum_x    $checksum_external";
    } >> "$file.xlink"    
    echo "linkage file created: $file.xlink"
    echo "File pushed to external storage: /external_storage/xchange_horizon/$file"

    rm "$file"
    echo "Original file removed"
}

function hrzn_pull () {
    echo "Pulling file from exchange..."
}

function hrzn_check () {
    echo "Checking file integrity..."
}