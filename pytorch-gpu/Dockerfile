ARG BASE_IMAGE=nvidia/cuda:10.2-base-ubuntu18.04
FROM ${BASE_IMAGE}

# Install pkg as root
USER root

# fix：apt-get update tmp key error
RUN chmod 1777 /tmp

# Install some basic utilities
RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    sudo \
    git \
    bzip2 \
    libx11-6 \
    && rm -rf /var/lib/apt/lists/*

RUN apt-get update && \
    apt-get install -y python3 && \
    apt-get install -y python3-venv

# Switch back to normal user with sudo to avoid accidental container runs as root
ARG USER_NORMAL=ocaes
RUN if id -u ${USER_NORMAL} >/dev/null 2>&1 ; then \
    echo "User ${USERNAME} exists."; \
    else useradd -ms /bin/bash ${USER_NORMAL} && \
    echo "${USER_NORMAL}:${USER_NORMAL}" | chpasswd && adduser ${USER_NORMAL} sudo; \
    fi
USER ${USER_NORMAL}

WORKDIR /home/${USER_NORMAL}

# Python virtual environment path. Do Not modify!
ARG VIRTUAL_ENV=venv
RUN python3 -m venv ${VIRTUAL_ENV}

# Accelerate pip and conda downloading
RUN . ${VIRTUAL_ENV}/bin/activate && \
    pip3 install pip -U && \
    pip3 config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple

USER root
# Python environments file path 
ARG PATH_REQUIREMENTS=requirements.txt
ADD ${PATH_REQUIREMENTS} /tmp/requirements.txt
RUN chown -R ${USER_NORMAL}:${USER_NORMAL} /tmp
RUN chmod -R 700 /tmp

USER ${USER_NORMAL}
RUN . ${VIRTUAL_ENV}/bin/activate && \
    pip3 install -r /tmp/requirements.txt

# Important, set python environment to $VIRTUAL_ENV
ENV PATH="/home/${USER_NORMAL}/$VIRTUAL_ENV/bin:$PATH"

USER ${USER_NORMAL}