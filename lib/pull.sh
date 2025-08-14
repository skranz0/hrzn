#!/bin/bash

# Output to stdout and write to logfile
exec > >(tee -a ./hrzn_pull.log) 2>&1


# Colors for better readability
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

function hrzn_pull () {
    function show_help () {
        echo "Pull files from external storage."
        echo "Usage: hrzn pull [options] <verge-file> ..."
        echo "Options:"
        echo "  -h, --help        Show this help message"
    }
    if [[ $# -eq 0 || "$1" == "-h" || "$1" == "--help" ]]; then
        show_help
        exit 1
    fi

    # TODO check if origin path is current location
    for verge_file in "$@"
    do
        if [[ ! -f "$verge_file" ]]; then
            echo -e "${RED}Linkage file not found:${NC} $verge_file"
            exit 1
        fi

        while IFS= read -r line; do
            if [[ $line == path_o* ]]; then
                if [[ $line -ne $(pwd)/* ]]; then
                    echo -e "${RED}Current path does not match origin path in verge file!${NC}"
                    echo -e "${YELLOW}If the file has been moved, use hrzn move to change the origin path.${NC}"
                    exit 3
                fi
            fi
            if [[ $line == path_x* ]]; then
                path_x=$(echo "$line" | cut -d' ' -f5)
                echo -e "${YELLOW}Retrieving path from linkage file:${NC} $path_x"
            elif [[ $line == checksum_x* ]]; then
                checksum_x=$(echo "$line" | cut -d' ' -f5)
            fi
        done < "$verge_file"
        if [[ ! -f "$path_x" ]]; then
            echo -e "${RED}File not found in external storage:${NC} $path_x"
            exit 1
        fi
        echo -e "${YELLOW}Copying file from external storage...${NC}"
        cp -i "$path_x" .
        checksum_local=$(md5sum "$path_x" | cut -d' ' -f1)
        echo -e "${YELLOW}Comparing checksums...${NC}"
        echo "Checksum local: $checksum_local"
        echo "Checksum external: $checksum_x"
        if [[ "$checksum_local" == "$checksum_x" ]]; then
            echo -e "${GREEN}File integrity check passed.${NC}"
        else
            echo -e "${RED}File integrity check failed.${NC}"
            exit 1
        fi
        echo -e "${GREEN}File pulled from external storage"
        rm "$path_x"
        echo -e "${GREEN}File removed from external storage"
        rm "$path_x.verge"
        rm "$verge_file"
        echo -e "${GREEN}Linkage file removed"
    done
}
