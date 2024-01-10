FROM ubuntu/ubuntu:latest

# Override the default huggingface cache directory.
ENV HF_HOME="/runpod-volume/.cache/huggingface/"
ENV HF_DATASETS_CACHE="/runpod-volume/.cache/huggingface/datasets/"
ENV DEFAULT_HF_METRICS_CACHE="/runpod-volume/.cache/huggingface/metrics/"
ENV DEFAULT_HF_MODULES_CACHE="/runpod-volume/.cache/huggingface/modules/"
ENV HUGGINGFACE_HUB_CACHE="/runpod-volume/.cache/huggingface/hub/"
ENV HUGGINGFACE_ASSETS_CACHE="/runpod-volume/.cache/huggingface/assets/"

# Faster transfer of models from the hub to the container
ENV HF_HUB_ENABLE_HF_TRANSFER="1"

# Shared python package cache
ENV VIRTUALENV_OVERRIDE_APP_DATA="/runpod-volume/.cache/virtualenv/"
ENV PIP_CACHE_DIR="/runpod-volume/.cache/pip/"

# Set Default Python Version
ENV PYTHON_VERSION="3.11"

WORKDIR /

RUN apt-get update --yes && \
    apt-get upgrade --yes && \

    apt install --yes --no-install-recommends \
    RUN apt-get update --yes && \
    apt-get upgrade --yes && \

    # Basic Utilities
    apt install --yes --no-install-recommends \
    bash \
    ca-certificates \
    curl \
    file \
    git \
    inotify-tools \
    libgl1 \
    vim \
    nano \
    tmux \
    nginx \

    # Required for SSH access
    openssh-server \

    procps \
    rsync \
    sudo \
    software-properties-common \
    unzip \
    wget \
    zip && \

    # Build Tools and Development
    apt install --yes --no-install-recommends \
    build-essential \
    make \
    cmake \
    gfortran \
    libblas-dev \
    liblapack-dev && \

        # Deep Learning Dependencies and Miscellaneous
    apt install --yes --no-install-recommends \
    libatlas-base-dev \
    libffi-dev \
    libhdf5-serial-dev \
    libsm6 \
    libssl-dev && \

    # File Systems and Storage
    apt install --yes --no-install-recommends \
    cifs-utils \
    nfs-common \
    zstd &&\

    # Add the Python PPA and install Python versions
    add-apt-repository ppa:deadsnakes/ppa && \
    apt install --yes --no-install-recommends \
    python3.11-dev \
    python3.11-venv \
    python3.11-distutils && \

    # Cleanup
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \

    # Set locale
    echo "en_US.UTF-8 UTF-8" > /etc/locale.gen

    # Install pip
RUN curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py && \
    python3.11 get-pip.py

# Get the latest pip for all python versions
RUN python3.11 -m pip install --upgrade pip

# Install virtualenv
RUN python3.11 -m pip install virtualenv

# NGINX Proxy
COPY --from=proxy nginx.conf /etc/nginx/nginx.conf
COPY --from=proxy readme.html /usr/share/nginx/html/readme.html
