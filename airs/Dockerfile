ARG AIRS_BASE_IMAGE=ubuntu:24.04
FROM ${AIRS_BASE_IMAGE}

ARG DEBIAN_FRONTEND="noninteractive"

RUN \
  echo "**** install runtime dependencies ****" && \
  apt-get update && \
  apt-get install -y \
    git && \
  echo "**** clean up ****" && \
  apt-get clean && \
  rm -rf \
    /config/* \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*

RUN curl -fsSL https://code-server.dev/install.sh | sh