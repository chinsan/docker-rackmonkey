# docker-rackmonkey

Docker container for [Rackmonkey 1.2.5-1][3]

"RackMonkey is a web-based tool for managing racks of equipment such as web servers, video encoders, routers and storage devices. Using a simple interface you can keep track of what's where, which OS it runs, when it was purchased, who it belongs and what it's used for. No more searching for spreadsheets or scribbled notes when you need to find a server: RackMonkey can quickly find any device and draw a rack diagram of its location. RackMonkey is free and open source (licensed under the GPL)."


## Install dependencies

  - [Docker][2]

To install docker in Ubuntu 14.04 use the commands:

    $ sudo apt-get update
    $ sudo apt-get install docker.io

 To install docker in other operating systems check [docker online documentation][4]

## Usage

To run container use the command below:

      $ docker run -d -p 80 quantumobject/docker-rackmonkey


## Accessing the Rackmonkey applications:

After that check with your browser at addresses plus the port assigined by docker:

  - **http://host_ip:port/**


This rackmonkey use sqlitle for database , if you need to use mysql you can use this Dockerfile and other file for reference to create your own container.

## More Info

About [Rackmonkey][1]

To help improve this container [docker-rackmonkey][5]

Example of [Rackmonkey][6]

[1]:https://flux.org.uk/projects/rackmonkey
[2]:https://www.docker.com
[3]:https://flux.org.uk/projects/rackmonkey
[4]:http://docs.docker.com
[5]:https://github.com/QuantumObject/docker-rackmonkey
[6]:http://www.quantumobject.com:49155
