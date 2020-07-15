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
RUN conda install -c conda-forge --yes --quiet \
    tensorflow-gpu \
    cudatoolkit=9.0 && \
    conda clean -tipsy && \
    fix-permissions $CONDA_DIR && \
    fix-permissions /home/$NB_USER

# Allow drivers installed by the nvidia-driver-installer to be located
ENV LD_LIBRARY_PATH=${LD_LIBRARY_PATH}:/usr/local/nvidia/lib64
# Also, utilities like `nvidia-smi` are installed here
ENV PATH=${PATH}:/usr/local/nvidia/bin