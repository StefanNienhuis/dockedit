FROM debian:bullseye

ARG OPENVSCODE_SERVER_VERSION=v1.74.3
ARG TARGETPLATFORM

RUN apt-get update -y && apt-get upgrade -y && apt-get install -y wget tini
RUN case "${TARGETPLATFORM}" in \
        "linux/amd64") OS=linux-x64 ;; \
        "linux/arm64") OS=linux-arm64 ;; \
        *) echo "Unsupported architecture: ${TARGETPLATFORM}" >&2 && exit 1 ;; \
    esac && \
    wget "https://github.com/gitpod-io/openvscode-server/releases/download/openvscode-server-${OPENVSCODE_SERVER_VERSION}/openvscode-server-${OPENVSCODE_SERVER_VERSION}-$OS.tar.gz" -O /tmp/openvscode-server.tar.gz && \
    mkdir /openvscode-server && \
    tar -xf /tmp/openvscode-server.tar.gz -C /openvscode-server --strip-components=1 && \
    rm -rf /var/lib/apt/lists/* /tmp/* 

ADD entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh /openvscode-server/bin/*

ENTRYPOINT [ "tini", "--", "/entrypoint.sh" ]