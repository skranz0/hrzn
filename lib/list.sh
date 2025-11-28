#!/bin/bash


# Output to stdout and write to logfile
exec > >(tee -a ./hrzn_pull.log) 2>&1


# Colors for better readability
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
NC='\033[0m' # No Color

function hrzn_list () {
    cat /nucleus/results/README.txt
}
