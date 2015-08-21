#!/bin/bash
# this script is designed to build and run a gmod server

version=$(date +"%F")
image="sharkwouter/gmod:${newversion}"

docker build -t ${image} .

docker run -d ${image} Steam/steamapps/common/GarrysModDS/srcds_run -game garrysmod +map gm_flatgrass
