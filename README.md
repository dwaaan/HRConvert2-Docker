# HRConvert2-Docker

Docker files for HRConvert2 from https://github.com/zelon88/HRConvert2 - A self-hosted, drag-and-drop, & nosql file conversion server that supports 62x file formats.


## Dockerfile (Building the image yourself)

1. $ git clone https://github.com/dwaaan/HRConvert2-Docker
2. Edit config.php
2. Set Ubuntu repos in Dockerfile (currently set to Australia)
3. $ docker build -t hrconvert2 .
4. run docker images, copy the image ID
5. docker run -i -t [ID]
 


