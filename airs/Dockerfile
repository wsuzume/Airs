ARG AIRS_BASE_IMAGE=ubuntu:24.04
FROM ${AIRS_BASE_IMAGE}

ARG S6_OVERLAY_VERSION=3.2.2.0
ARG DEBIAN_FRONTEND="noninteractive"

## modify users and groups
RUN set -x \
    ## create nginx user/group first to ensure consistent UID/GID across different base images
    && groupadd --system --gid 101 nginx \
    && useradd --system --gid nginx --no-create-home --home /nonexistent --comment "nginx user" --shell /bin/false --uid 101 nginx \
    ## remove default ubuntu user with UID 1000 to avoid conflicts with host user
    && if id -u 1000 > /dev/null 2>&1; then \
         userdel --remove $(id -un 1000); \
       fi

## install dependencies
RUN set -x \
    && apt-get update \
    && apt-get install --no-install-recommends --no-install-suggests -y \
        # used in this Dockerfile
        curl ca-certificates xz-utils \
        # used in s6-overlay scripts
        jq rsync \
        # utilities for users
        openssh-server vim git tree python3 \
    && rm -rf /var/lib/apt/lists/*

## install code-server
# install code-server
RUN curl -fsSL https://code-server.dev/install.sh | sh

# install code-server extensions
RUN code-server --extensions-dir /config/extensions --install-extension ms-ceintl.vscode-language-pack-ja \
    && code-server --extensions-dir /config/extensions --install-extension alefragnani.project-manager \
    && code-server --extensions-dir /config/extensions --install-extension hediet.vscode-drawio \
    && code-server --extensions-dir /config/extensions --install-extension ms-vscode.makefile-tools \
    && code-server --extensions-dir /config/extensions --install-extension golang.go \
    && code-server --extensions-dir /config/extensions --install-extension ms-python.python \
    && code-server --extensions-dir /config/extensions --install-extension ms-toolsai.jupyter \
    && code-server --extensions-dir /config/extensions --install-extension anthropic.claude-code \
    && code-server --extensions-dir /config/extensions --install-extension github.copilot-chat \
    && code-server --extensions-dir /config/extensions --install-extension github.vscode-pull-request-github \
    && code-server --extensions-dir /config/extensions --install-extension github.vscode-github-actions \
    && chmod -R a+rX /config/extensions

## set up s6-overlay
# download
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-noarch.tar.xz /tmp
ADD https://github.com/just-containers/s6-overlay/releases/download/v${S6_OVERLAY_VERSION}/s6-overlay-x86_64.tar.xz /tmp

# extract
RUN tar -C / -Jxpf /tmp/s6-overlay-noarch.tar.xz \
    && tar -C / -Jxpf /tmp/s6-overlay-x86_64.tar.xz

## configure
# s6-overlay
COPY root/etc/s6-overlay/ /etc/s6-overlay/

# set entrypoint
ENTRYPOINT ["/init"]

RUN mkdir -p /work \
    && mkdir -p /config/extensions \
    && chmod a+x /config
