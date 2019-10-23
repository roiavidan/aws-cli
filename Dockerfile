FROM alpine:3.10

ENTRYPOINT ["aws"]

RUN apk add --no-cache python3 groff && \
  pip3 install awscli==1.16.262
