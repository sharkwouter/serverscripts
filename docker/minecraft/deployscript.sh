#!/bin/bash
# this script is designed to build and run a gmod server

# set variables
baseimage="debian:stable"
version=$(date "+%Y%m%d")
outputimage="sharkwouter/minecraft"
serverurl="https://s3.amazonaws.com/Minecraft.Download/versions/1.8.8/minecraft_server.1.8.8.jar"

# create the docker file
cat > dockerfile << EOF
FROM ${baseimage}
MAINTAINER Wouter Wijsman <wwijsman@live.nl>
RUN apt-get update && apt-get dist-upgrade
RUN apt-get install --no-install-recommends default-jre-headless wget -y
RUN wget ${serverurl}
RUN echo "eula=true" > eula.txt
ENTRYPOINT ["java", "-Xmx1024M", "-Xms1024M", "-jar", "minecraft_server.1.8.8.jar", "nogui"]
EOF

# update base image
docker pull ${baseimage}

# build docker image
docker build -t ${outputimage} .

# start server
echo -e "\n Starting server:"
docker run -d ${outputimage}

# cleanup
rm dockerfile
