#!/bin/bash
# this script is designed to build and run a gmod server

version=$(date +"%F")
image="sharkwouter/minecraft:${newversion}"

docker build -t ${image} .

docker run -d ${image} java -Xmx1024M -Xms1024M -jar minecraft_server.1.8.8.jar nogui
