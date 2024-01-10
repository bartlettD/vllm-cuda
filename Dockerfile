FROM ubuntu:jammy

RUN apt-get update --yes && \
    apt-get upgrade --yes && \

    apt install --yes --no-install-recommends \
    python3.11 python3.11-dev python3-distutils
