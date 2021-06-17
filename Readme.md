# Docker-roda

Sample docker-enabled ruby (Roda) app as base for a JSON API.


Sample commands:

Build:

    docker build -t droda .

Run:

    docker run droda  -p 3000:3000

Rebuild and run:

    docker build -t roda . && docker run -p 3000:3000 roda 

Bash:

    docker run  -ti droda bash


 docker run -it --rm --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3-management
