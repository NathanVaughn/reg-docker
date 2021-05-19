# Docker Image for [reg](https://github.com/genuinetools/reg)

[![](https://img.shields.io/docker/v/nathanvaughn/reg)](https://hub.docker.com/r/nathanvaughn/reg)
[![](https://img.shields.io/docker/image-size/nathanvaughn/reg)](https://hub.docker.com/r/nathanvaughn/reg)
[![](https://img.shields.io/docker/pulls/nathanvaughn/reg)](https://hub.docker.com/r/nathanvaughn/reg)
[![](https://img.shields.io/github/license/nathanvaughn/reg-docker)](https://github.com/NathanVaughn/reg-docker)

This is a **unofficial** multi-architecture Docker image for
[reg](https://github.com/genuinetools/reg).

## Usage

For the most part, see [Usage](https://github.com/genuinetools/reg#usage).

One note, if you want to use this in Docker compose to run a web server for example, this
will **NOT** work:

```yml
version: '3'

services:
  app:
    environment:
        - USERNAME=user
        - PASSWORD=pass
    command: server -r cr.nthnv.me -u ${USERNAME} -p ${PASSWORD}
    image: cr.nthnv.me/reg
    ports:
        - 80:8080
```

Docker compose won't be able to substitute in the environment variable s
as you created it in the same service. Instead, create a `.env` file with the desired
environment variables in the same directory, and that will work.

```env
# .env
USERNAME=user
PASSWORD=pass
```

```yml
version: '3'

services:
  app:
    command: server -r cr.nthnv.me -u ${USERNAME} -p ${PASSWORD}
    image: cr.nthnv.me/reg
    ports:
        - 80:8080
```

## Registry

This image is available from 3 different registries. Choose whichever you want:

 - [docker.io/nathanvaughn/reg](https://hub.docker.com/r/nathanvaughn/reg)
 - [ghcr.io/nathanvaughn/reg](https://github.com/users/nathanvaughn/packages/container/package/reg)
 - [cr.nthnv.me/reg](https://cr.nthnv.me/repo/reg) (experimental)
