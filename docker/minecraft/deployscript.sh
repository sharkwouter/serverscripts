#!/bin/bash
# this script is designed to build and run a gmod server

# set variables
baseimage="debian:stable"
version=$(date "+%Y%m%d")
outputimage="sharkwouter/minecraft"
serverurl="https://s3.amazonaws.com/Minecraft.Download/versions/1.8.9/minecraft_server.1.8.9.jar"

# create the docker file
cat > dockerfile << EOF
FROM ${baseimage}
MAINTAINER Wouter Wijsman <wwijsman@live.nl>
RUN apt-get update && apt-get dist-upgrade -y
RUN apt-get install --no-install-recommends default-jre-headless wget -y
RUN wget "${serverurl}" -O minecraft_server.jar
RUN echo "eula=true" > eula.txt
RUN mkdir world
ENTRYPOINT ["java", "-Xmx1024M", "-Xms1024M", "-jar", "minecraft_server.jar", "nogui"]
EOF

# update base image
docker pull ${baseimage}

# build docker image
docker build -t ${outputimage} .

# start server
echo -e "\n Starting server:"
mkdir -p ~/minecraft-world
docker run -d -p=25565:25565 -v ~/minecraft-world:/world ${outputimage}

# cleanup
rm dockerfile
