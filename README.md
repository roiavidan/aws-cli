# Dockerized AWS CLI

This image provides a minimal and rootless [AWS CLI](https://aws.amazon.com/cli/) v1.16.266 command inside a _Docker_ container.

It is based on Google's [Distroless](https://github.com/GoogleContainerTools/distroless).

# Usage

```bash
$ docker run --rm -t \
  roiavidan/aws-cli ...
```
