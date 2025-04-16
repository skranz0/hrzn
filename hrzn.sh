#!/bin/bash


#############################
# author: Stefan Kranz
# https://github.com/skranz0
#############################

# import funtions
source ./lib/push.sh
source ./lib/pull.sh

# function for help text
function show_help() {
    echo "Usage: hrzn.sh [options] <file>"
    echo "Options:"
    echo "  -h, --help        Show this help message"
    echo "  push        Push file to exchange"
    echo "  pull        Pull file from exchange"
    #echo "  check       Check file integrity"
    #echo "  link        Create exchange link file"
}

# main logic
if [[ $# -eq 0 ]]; then
    show_help
    exit 1
fi

# first argument is the subcommand
command="$1"
shift # remove first parameter

case "$command" in
    -h|--help)
        show_help
        ;;
    push)
        hrzn_push "$@"
        ;;
    pull)
        hrzn_pull "$@"
        ;;
    *)
        echo "Unknown command: $command"
        show_help
        exit 1
        ;;
esac