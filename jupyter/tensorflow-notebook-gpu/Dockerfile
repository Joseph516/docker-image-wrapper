# Copyright (c) Jupyter Development Team.
# Distributed under the terms of the Modified BSD License.

# ARG BASE_CONTAINER=jupyter/scipy-notebook
# FROM $BASE_CONTAINER

# LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

# # Install Tensorflow
# RUN pip install --quiet --no-cache-dir \
#     'tensorflow==2.2.0' && \
#     fix-permissions "${CONDA_DIR}" && \
#     fix-permissions "/home/${NB_USER}"


# Reference from: https://github.com/jupyterhub/zero-to-jupyterhub-k8s/issues/994
# For the latest tag, see: https://hub.docker.com/r/jupyter/datascience-notebook/tags/
FROM jupyter/scipy-notebook:ea01ec4d9f57

LABEL maintainer="Jupyter Project <jupyter@googlegroups.com>"

# GPU powered ML
# ----------------------------------------
RUN conda config --add channels conda-forge && \
    conda config --set channel_priority flexible

# Default install cudatoolkit&cudnn when install tensorflow-gpu
RUN conda install -c conda-forge --yes --quiet \
    tensorflow-gpu=2.2.0 && \
    cudatoolkit=9.2 && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Install cuda 10.2
# RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/cuda-ubuntu1604.pin && \
#     sudo mv cuda-ubuntu1604.pin /etc/apt/preferences.d/cuda-repository-pin-600 && \
#     sudo apt-key adv --fetch-keys http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub && \
#     sudo add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/ /" && \
#     sudo apt-get update && \
#     sudo apt-get -y install cuda

# Allow drivers installed by the nvidia-driver-installer to be located
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/nvidia/lib64:/usr/local/nvidia/lib:/usr/local/cuda-9.2/lib64
# Also, utilities like `nvidia-smi` are installed here
ENV PATH=${PATH}:/usr/local/nvidia/bin:/usr/local/cuda-9.2/bin:/usr/local/cuda-9.2/NsightCompute-2019.1

ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=compute,utility
ENV NVIDIA_REQUIRE_CUDA=cuda>=9.2