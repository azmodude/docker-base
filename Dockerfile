FROM ubuntu:latest
LABEL maintainer="Gordon Schulz <gordon.schulz@gmail.com>"

COPY --from=builder /remco /usr/local/bin/remco
COPY --from=builder /gosu /usr/local/bin/gosu

RUN apt-get update && apt-get -y --no-install-recommends install \
        apt-transport-https curl ca-certificates software-properties-common && \
        apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ARG S6_OVERLAY_VERSION
RUN curl -s -S -L -o /tmp/s6-overlay-amd64.tar.gz \
        https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz && \
        tar xzf /tmp/s6-overlay-amd64.tar.gz -C / && \
        rm /tmp/s6-overlay-amd64.tar.gz

ENTRYPOINT ["/init"]
