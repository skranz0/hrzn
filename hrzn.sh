#!/bin/bash


#############################
# author: Stefan Kranz
# https://codeberg.org/skranz0
#############################

# import functions

source /usr/local/bin/lib/hrzn/push.sh
source /usr/local/bin/lib/hrzn/pull.sh
source /usr/local/bin/lib/hrzn/move.sh
source /usr/local/bin/lib/hrzn/show_x.sh
source /usr/local/bin/lib/hrzn/change_external.sh

# function for help text

function show_help() {
    echo "Usage: hrzn.sh [options] <file>"
    echo "Options:"
    echo "  -h, --help        Show this help message"
    echo "  push            Push file to exchange"
    echo "  pull            Pull file from exchange"
    echo "  move            Change the origin path in a verge file"
    echo "  show_x          Show the path of the external storage"
    echo "  change-external Find verge files and change the path of the external storage"
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
    move)
        hrzn_move "$@"
        ;;
    show_x)
        hrzn_show_x
        ;;
    change-external)
        change-external
        ;;
    *)
        echo "Unknown command: $command"
        show_help
        exit 1
        ;;
esac
