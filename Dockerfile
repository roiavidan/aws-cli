FROM python:3.5.3 AS BASE

# Install binary dependencies which AWS CLI needs - groff & less
RUN apt-get update \
  && apt-get install -y --no-install-recommends groff less

# Install AWS CLI & docutils
RUN pip3 install -t /tmp/awscli awscli==1.16.266 \
  && pip3 install -t /tmp/docutils docutils \
  && find /tmp -name '__pycache__' | xargs rm -rf \
  && find /tmp -name '*dist-info*' | xargs rm -rf

FROM gcr.io/distroless/python3
ENTRYPOINT ["python", "-m", "awscli"]
ENV TERM=xterm

# Copy groff + dependencies
COPY --from=BASE /usr/bin/groff /usr/bin/
COPY --from=BASE /usr/bin/troff /usr/bin/
COPY --from=BASE /usr/bin/grotty /usr/bin/
COPY --from=BASE /usr/share/groff/1.22.2/font/devascii/* /usr/share/groff/1.22.2/font/devascii/
COPY --from=BASE /usr/share/groff/1.22.2/tmac/andoc.tmac /usr/share/groff/1.22.2/tmac/
COPY --from=BASE /usr/share/groff/1.22.2/tmac/man.tmac /usr/share/groff/1.22.2/tmac/

# Copy less + dependencies
COPY --from=BASE /usr/bin/less /usr/bin/
COPY --from=BASE /lib/terminfo/x/xterm /lib/terminfo/x/
COPY --from=BASE /lib/x86_64-linux-gnu/libtinfo.so.5 /lib/x86_64-linux-gnu/

# Copy AWS CLI & docutils packages
COPY --from=BASE /tmp/* /usr/lib/python3.5/

# Run as a non-root user
USER nonroot
