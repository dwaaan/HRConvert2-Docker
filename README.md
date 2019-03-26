![Docker Cloud Automated build](https://img.shields.io/docker/cloud/automated/dwaaan/hrconvert2-docker.svg)![Docker Cloud Build Status](https://img.shields.io/docker/cloud/build/dwaaan/hrconvert2-docker.svg) [![](https://images.microbadger.com/badges/image/dwaaan/hrconvert2-docker.svg)](https://microbadger.com/images/dwaaan/hrconvert2-docker )

# HRConvert2-Docker

Docker files for HRConvert2 from https://github.com/zelon88/HRConvert2 - A self-hosted, drag-and-drop, & nosql file conversion server that supports 62x file formats.

## Docker Hub
https://hub.docker.com/r/dwaaan/hrconvert2-docker
docker pull dwaaan/hrconvert2-docker


## Dockerfile (Building the image yourself)

1. git clone https://github.com/dwaaan/HRConvert2-Docker
2. Edit config.php
3. Set Ubuntu repos in Dockerfile (currently set to Australia)
4. docker build -t hrconvert2 .
5. docker images,copy the image ID
6. docker run -i -t hrconvert2
 

## docker-compose.yml

1. git clone https://github.com/dwaaan/HRConvert2-Docker
2. Edit config.php
3. docker-compose up (-d to run in background)
