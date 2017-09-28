# cloud9-docker-cli

Cloud9 IDE + Docker CLI based on Alpine

Why combine Cloud9 with alpine?

> so you can Edit your compose files, mount your Docker-Socket and spin up new Services/Stacks with ease.

Compose-V3 Example
```
version: '3'

services:
  webide:
    image: berndinox/cloud9-docker
    ports:
      - 8000:8000
    volumes:
      - /data:/workspace
      - /var/run/docker.sock:/var/run/docker.sock
    environment:
      - USERNAME=USER
      - PASSWORD=PASS

networks:
  default:
    driver: overlay
```

Preview:
![alt text](https://raw.githubusercontent.com/Berndinox/cloud9-docker-cli/master/cloud9.png)
