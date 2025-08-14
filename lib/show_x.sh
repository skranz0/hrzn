#!/bin/bash

function hrzn_show_x () {
    external_storage=""
    source "/etc/hrzn/config"
    
    echo "External storage is set to $external_storage"
}
