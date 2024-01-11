FROM ubuntu:mantic

# Get python
RUN apt-get update --yes && \
    apt-get upgrade --yes && \

    apt install --yes --no-install-recommends \
    python3.11 python3.11-dev python3-distutils python3-pip git

# Get torch and xformers
RUN pip3 install --no-cache-dir torch --index-url https://download.pytorch.org/whl/cu118 && \
    pip3 install --no-cache-dir -U xformers --index-url https://download.pytorch.org/whl/cu118
