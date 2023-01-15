# dockedit

Utility for editing files in Docker volumes using the OpenVSCode Server Web IDE. A UID and GID can be set to edit files that are not owned by `1000:1000`.

## Usage

Modify the `HOST` and `PORT` parameters in `dockedit.sh` and add it to your path for ease of use.

```sh
dockedit.sh VOLUME_NAME UID GID
```

When UID and GID are the same
```sh
dockedit.sh VOLUME_NAME UID/GID
```

Using an alias
```sh
dockedit.sh ALIAS
```

### Aliases

Aliases can be configured in `dockedit.sh` in the case statement.

Example: `"mqtt") VOLUME="mqtt"; PUID=1883; PGID=1883 ;;`

```
dockedit.sh mqtt
```

## Building

The Docker image can be built for multiple architectures.

```sh
docker buildx build --platform linux/amd64,linux/arm64 -t stefannienhuis/dockedit:latest --push .
```