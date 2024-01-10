FROM ubuntu:jammy

# Get python
RUN apt-get update --yes && \
    apt-get upgrade --yes && \

    apt install --yes --no-install-recommends \
    python3.11 python3.11-dev python3-distutils python3-pip git

# Get torch and xformers
RUN pip3 install torch --index-url https://download.pytorch.org/whl/cu118 && \
    pip3 install -U xformers --index-url https://download.pytorch.org/whl/cu118
