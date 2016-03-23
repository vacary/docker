# Shim image that adds in the global fenics.conf used by all and allows easy
# bumping of package versions using one set of environment variables.
#
# While not intended for use by users, an image is hosted at:
#
#    https://quay.io/repository/fenicsproject/dev-env-base
#
# Author:
# Jack S. Hale <jack.hale@uni.lu>

FROM quay.io/fenicsproject/base:latest
MAINTAINER fenics-project <fenics@fenicsproject.org>

# Non-Python utilities and libraries
USER root
RUN apt-get -qq update && \
    apt-get -y --with-new-pkgs upgrade && \
    apt-get -y install \
        bison cmake flex g++ gfortran git ipython openmpi-bin pkg-config wget \
        libopenblas-dev libboost-filesystem-dev libboost-system-dev \
        libboost-program-options-dev libboost-thread-dev libboost-timer-dev \
        libboost-iostreams-dev libcln-dev libcppunit-dev libeigen3-dev \ 
        liblapack-dev libmpfr-dev libopenmpi-dev libhwloc-dev libpcre3-dev \
        libhdf5-openmpi-dev libcgal-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Our helper scripts
COPY fenics.conf $HOME/fenics.conf
COPY fenics.env.conf $HOME/fenics.env.conf
COPY bin $HOME/bin
RUN chown -R fenics:fenics $HOME

USER fenics

RUN echo "source /home/fenics/fenics.env.conf" >> /home/fenics/.bash_profile && \
    echo "source /home/fenics/fenics.conf" >> /home/fenics/.bashrc

# Version numbers
ENV PETSC_VERSION=3.6.3 \
    SLEPC_VERSION=3.6.2 \
    SWIG_VERSION=3.0.8 \
    PETSC4PY_VERSION=3.6.0 \
    SLEPC4PY_VERSION=3.6.0 \
    TRILINOS_VERSION=12.6.1
