FROM jupyter/scipy-notebook:latest

USER root
RUN apt-get update && apt-get install -y git

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -y install gcc mono-mcs musl-dev mdbtools ssh && \
    rm -rf /var/lib/apt/lists/*

# Switch back to notebook user (defined in the base image)
USER $NB_UID

# Update conda
RUN conda update -n base conda -y

# Install required packages on top of base Jupyter image
RUN conda install -y \
  pandas \
  nltk \
  scipy \
  numpy \
  scikit-learn \
  tensorflow \
  matplotlib \
  jupyterlab-git \
  tabulate

# RUN conda install -c conda-forge/label/prerelease-jupyterlab jupyterlab

RUN jupyter labextension install @jupyterlab/git
RUN jupyter serverextension enable --py jupyterlab_git

# Upgrade juptyer-core (4.6.2 for insecure writes)
RUN python -m pip install --upgrade jupyter-core

# Insecure writes required for homes on network share
ENV JUPYTER_ALLOW_INSECURE_WRITES 1
