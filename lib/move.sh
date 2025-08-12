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
    
    if [[ ! -f "$verge_file" ]]; then
        echo -e "${RED}Linkage file not found:${NC} $verge_file"
        exit 1
    fi
    
    while IFS= read -r line; do
        # TODO add functionality
    done < $verge_file
}