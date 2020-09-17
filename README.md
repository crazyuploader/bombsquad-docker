## Dockerized BombSquad Server

[![Docker Pulls](https://img.shields.io/docker/pulls/crazyuploader/bombsquad?style=flat-square)](https://hub.docker.com/r/crazyuploader/bombsquad)

### Huge thanks to [Alibo](https://github.com/alibo/bombsquad-docker)

Docker image for server of game [BombSquad Game](https://www.froemling.net/apps/bombsquad)

### Usage
```bash
docker run -d -it \
           -p 43210:43210/udp \
           --name bombsquad \
           -v $(pwd)/config.yaml:/app/bombsquad-server/config.yaml \
           crazyuploader/bombsquad
```

### DockerHub
https://hub.docker.com/r/crazyuploader/bombsquad
