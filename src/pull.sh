#!/bin/bash


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
        echo "Linkage file not found: $xlnk_file"
        exit 1
    fi

    while IFS= read -r line; do
        echo "$line"
        if [[ $line == path_x* ]]; then
            path_x=$(echo "$line" | cut -d' ' -f5)
            echo "Retrieving path from linkage file: $path_x"
        elif [[ $line == checksum_x* ]]; then
            checksum_x=$(echo "$line" | cut -d' ' -f5)
        fi
    done < "$xlnk_file"
    if [[ ! -f "$path_x" ]]; then
        echo "File not found in external storage: $path_x"
        exit 1
    fi
    echo "Copying file from external storage..."
    cp -i "$path_x" .
    checksum_local=$(md5sum "$path_x" | cut -d' ' -f1)
    echo "Comparing checksums..."
    echo "Checksum local: $checksum_local"
    echo "Checksum external: $checksum_x"
    if [[ "$checksum_local" == "$checksum_x" ]]; then
        echo "File integrity check passed."
    else
        echo "File integrity check failed."
        exit 1
    fi
    echo "File pulled from external storage: $path_x"
    rm "$path_x"
    echo "File removed from external storage: $path_x"
    rm "$xlnk_file"
    echo "Linkage file removed: $xlnk_file"
}