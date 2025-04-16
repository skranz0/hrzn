#!/bin/bash

# make this without screen session
# move process to background
# do not remove original file if md5sum are not equal
# write logs

#$file = $1

#1
cp file.txt /external_storage/xchange_horizon/
md5sum file.txt > file.txt.md5
md5sum /external_storage/xchange_horizon/file.txt > /external_storage/xchange_horizon/file.txt.md5