rackmonkey
==========

Dockerfile to be use to build image for docker container with Rackmonkey 1.2.5-1


To use it :

docker run -d -p 80 -p 22 angelrr7702/rackmonkey

Them need to  check port that docker will associate with the container and them check it at your browser host:port
 

 Rackmonkey was developed by Will Green and project page with more info at
 
https://flux.org.uk/projects/rackmonkey/


This rackmonkey use sqlitle for database , if you need to use mysql you can use this Dockerfile and other file for reference ...


Need to log in to the container by ssh (root:rootprovisional) and them : passwd ????? ==> to change root password
