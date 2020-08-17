FROM jupyter/scipy-notebook:48052e429f69

USER root
RUN apt-get update && apt-get install -y git

ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update && \
    apt-get -y install gcc mono-mcs musl-dev mdbtools ssh vim language-pack-de gnuplot graphviz && \
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

# Add some misc packages via PyPI
RUN python -m pip install matplotlib_venn psycopg2-binary
RUN python -m pip install git+git://github.com/FreeBugs/pyGeoDb.git
RUN python -m pip install pyprind
RUN python -m pip install plotly
RUN python -m pip install snap-stanford
RUN python -m pip install mgzip

RUN conda install -y graph-tool
