ARG AIRS_BASE_IMAGE=ubuntu:24.04
FROM ${AIRS_BASE_IMAGE}

ARG S6_OVERLAY_VERSION=3.2.2.0
ARG DEBIAN_FRONTEND="noninteractive"

## install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    # used in this Dockerfile
    curl \
    ca-certificates \
    xz-utils \
    # used in s6-overlay scripts
    jq rsync \
    # utilites for users
    openssh-server vim git tree python3 \
    && rm -rf /var/lib/apt/lists/*

## install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

## set up s6-overlay
# download
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp

# extract
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz \
    && tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

# configure
COPY root/etc/s6-overlay/ /etc/s6-overlay/

# set entrypoint
ENTRYPOINT ["/init"]

## remove default ubuntu user with UID 1000 to avoid conflicts with host user
RUN if grep -q "1000" /etc/passwd; then \
        userdel --remove $(id -un "1000"); \
    fi

RUN mkdir -p /work \
    && mkdir -p /config/extensions \
    && chmod a+x /config

# install code-server extensions
RUN code-server --extensions-dir /config/extensions --install-extension alefragnani.project-manager \
    && code-server --extensions-dir /config/extensions --install-extension ms-toolsai.jupyter \
    && chmod -R a+rX /config/extensions
