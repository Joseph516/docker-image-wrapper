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
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Allow drivers installed by the nvidia-driver-installer to be located
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/nvidia/lib64:/usr/local/nvidia/lib:/usr/local/cuda-10.2/bin/lib64
# Also, utilities like `nvidia-smi` are installed here
ENV PATH=${PATH}:/usr/local/nvidia/bin:/usr/local/cuda-10.2/bin:/usr/local/cuda/bin:

# "PATH=/usr/local/nvidia/bin:/usr/local/cuda/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin",
#                 "CUDA_VERSION=8.0.61",
#                 "CUDA_PKG_VERSION=8-0=8.0.61-1",
#                 "LD_LIBRARY_PATH=/usr/local/nvidia/lib:/usr/local/nvidia/lib64",
#                 "NVIDIA_VISIBLE_DEVICES=all",
#                 "NVIDIA_DRIVER_CAPABILITIES=compute,utility",
#                 "NVIDIA_REQUIRE_CUDA=cuda>=8.0",
#                 "CUDNN_VERSION=5.1.10",
#                 "DIGITS_VERSION=6.0",
#                 "DIGITS_JOBS_DIR=/jobs",
#                 "DIGITS_LOGFILE_FILENAME=/jobs/digits.log",
#                 "PYTHONPATH=/usr/local/python"