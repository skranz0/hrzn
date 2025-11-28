#!/bin/bash


#############################
# author: Stefan Kranz
# https://codeberg.org/skranz0
#############################

# import functions

source /software/lib/hrzn/push.sh
source /software/lib/hrzn/pull.sh
source /software/lib/hrzn/list.sh

# function for help text

function show_help() {
    echo "Usage: hrzn.sh [options] <file>"
    echo "Options:"
    echo "  -h, --help        Show this help message"
    echo "  push            Push file to exchange"
    echo "  pull            Pull file from exchange"
    echo "  list            List available directories and subdirectories"
    exit 0
}

## main logic ##

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
    list)
        hrzn_list
        ;;
    *)
        echo "Unknown command: $command"
        show_help
        exit 1
        ;;
esac
