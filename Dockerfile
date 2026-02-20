# XVM — Docker Build
#
# Builds XVM from source in a reproducible Linux environment.
# Produces .wotmod (WG) and/or .mtmod (Lesta) in /build/~output/deploy/.
#
# Build:
#   docker build --platform linux/amd64 -t xvm-build .
#
# Build a specific flavor:
#   docker build --platform linux/amd64 --build-arg FLAVOR=lesta -t xvm-build .
#
# Extract artifacts:
#   docker run --rm xvm-build cat /build/~output/deploy/*.wotmod > xvm.wotmod
#
# Or copy out:
#   id=$(docker create xvm-build)
#   docker cp "$id:/build/~output/deploy/" ./output/
#   docker rm "$id"

FROM ubuntu:20.04 AS base

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
        openjdk-11-jdk-headless \
        python2.7 \
        zip \
        unzip \
        patch \
        curl \
        ca-certificates \
    && ln -sf /usr/bin/python2.7 /usr/bin/python2 \
    && ln -sf /usr/bin/python2.7 /usr/bin/python \
    && rm -rf /var/lib/apt/lists/*

# Apache Royale 0.9.12
RUN mkdir -p /opt/apache-royale \
    && curl -fSL "https://dlcdn.apache.org/royale/0.9.12/binaries/apache-royale-0.9.12-bin-js-swf.zip" \
        -o /tmp/royale.zip \
    && unzip -q /tmp/royale.zip -d /opt/apache-royale/ \
    && rm /tmp/royale.zip

ENV ROYALE_HOME=/opt/apache-royale/royale-asjs

# Verify tools
RUN java -version \
    && python2.7 --version \
    && test -f "$ROYALE_HOME/js/lib/mxmlc.jar"

# ---------------------------------------------------------------------------

FROM base AS build

ARG FLAVOR=wg
ARG VERSION=

WORKDIR /build
COPY . /build/

RUN python2.7 build.py --flavor=${FLAVOR} ${VERSION:+--version=${VERSION}}
