FROM jupyter/scipy-notebook:latest

USER root
RUN apt-get update && apt-get install -y git

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -y install gcc mono-mcs musl-dev mdbtools ssh vim language-pack-de && \
    rm -rf /var/lib/apt/lists/*

# Switch back to notebook user (defined in the base image)
USER $NB_UID

# Update anaconda
RUN conda update -n base conda -y

# See issue on github: https://github.com/conda/conda/issues/9367
RUN conda config --set channel_priority false

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
  tabulate \
  xlsxwriter

# No git support until this has been merged: https://github.com/jupyterlab/jupyterlab-git/pull/520
#RUN jupyter labextension install @jupyterlab/git
#RUN jupyter serverextension enable --py jupyterlab_git

# Spreadsheet support for jupyterlab
RUN jupyter labextension install jupyterlab-spreadsheet

RUN jupyter lab build

# Upgrade juptyer-core (4.6.2 for insecure writes)
RUN python -m pip install --upgrade jupyter-core

# Add multithreaded gzip
RUN python -m pip install mgzip
