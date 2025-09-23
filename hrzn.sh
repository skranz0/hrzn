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
    echo "  uninstall       Uninstall hrzn from the system"
}

## main logic ##

if [[ $# -eq 0 ]]; then
    show_help
    exit 1
fi

# first argument is the subcommand

command="$1"
shift # remove first parameter

function uninstall () {
    echo "This will remove hrzn and all its resources from the system."
    echo "Continue?"
    select continue in "Yes" "No"; do
        case $continue in
            Yes ) break;;
            No ) exit;;
        esac
    done
    echo "Search for remaining verge files before?"
    select search in "Yes" "No"; do
        case $search in
            Yes ) {
                read -p "Enter starting directory to start recursive search: " search_start
                remaining_verges=$(find $search_start -type f -name "*verge")
                echo "${#remaining_verges[@]} verge files found. Continue with deinstallation anyway?"
                select after_search in "Yes" "No"; do
                    case $after_search in
                        Yes ) break;;
                        No ) exit;;
                    esac
                done
            };;
            No ) break;;
        esac
    done
    echo "Removing auxillary scripts"
    rm -r /usr/local/bin/lib/hrzn
    echo "Removing config file"
    rm -r /etc/hrzn
    echo "Removing main file"
    rm /usr/local/bin/hrzn 
    echo "Uninstallation finished"
}

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
    uninstall)
        uninstall
        ;;
    *)
        echo "Unknown command: $command"
        show_help
        exit 1
        ;;
esac
