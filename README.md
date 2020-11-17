# light-standalone-drawio

## Example of use

```console
$ docker run -p 80:80 -e PUID=1000 -e PGID=1000 -e TZ=Europe/Paris -v /your/directory:/data light-standalone-drawio
```

You need to use reverse-proxy (for example Traefik) for TLS and/or auth.

## Configuration env var

- PUID: User ID - if your filesystem use 1000, set 1000 ! default to nginx
- PGID: Group ID ; default empty

Add versions ? Each save = new version ? Ability to read them and restore one ? Handle multiples files ?
