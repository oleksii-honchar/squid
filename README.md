# squid
[Squid](http://www.squid-cache.org/) proxy docker image with piped logs for `arm64`

## Intention

- To have minimalistic, small size, `arm64` based squid image
- No log files inside the container to get rid of log rotation

## Description

Named pipes used for `squid` both `cache` and `access` logs. Pipes forwards logs to stdout of `PID 1`. Where they are collected by docker log driver. So, no log rotate care inside container needed. More details in [entrypoint.sh](entrypoint.sh) and [squid.conf.dist](squid.conf.dist)

## How to use

```bash
make build # build image with IMAGE_TAG
make up # run demo container
make logs # check logs
```

