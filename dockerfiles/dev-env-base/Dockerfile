# Shim image that adds in the global fenics.env.conf and bin/ used by all and
# allows easy bumping of package versions using one set of environment
# variables.
#
# While not intended for use by users, an image is hosted at:
#
#    https://quay.io/repository/fenicsproject/dev-env-base
#
# Author:
# Jack S. Hale <jack.hale@uni.lu>
# Jan Blechta <blechta@karlin.mff.cuni.cz>

FROM quay.io/fenicsproject/base:latest
MAINTAINER fenics-project <fenics-support@googlegroups.com>

# Non-Python utilities and libraries
USER root
RUN apt-get -qq update && \
    apt-get -y --with-new-pkgs upgrade && \
    apt-get -y install \
        bison \
        cmake \
        flex \
        g++ \
        gfortran \
        git \
        libboost-filesystem-dev \
        libboost-iostreams-dev \
        libboost-program-options-dev \
        libboost-system-dev \
        libboost-thread-dev \
        libboost-timer-dev \
        libeigen3-dev \
        liblapack-dev \
        libmpich-dev \
        libopenblas-dev \
        libpcre3-dev \
        libhdf5-mpich-dev \
        libgmp-dev \
        libcln-dev \
        libmpfr-dev \
        mpich \
        nano \
        pkg-config \
        wget && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Our helper scripts
COPY fenics.env.conf $FENICS_HOME/fenics.env.conf
COPY bin $FENICS_HOME/bin
RUN mkdir $FENICS_HOME/build && \
    chown -R fenics:fenics $FENICS_HOME

USER fenics
RUN echo 'source ~/.profile' >> /home/fenics/.bash_profile && \
    echo '. ~/fenics.env.conf' >> /home/fenics/.profile

# Environment variables
ENV PETSC_VERSION=3.7.3 \
    SLEPC_VERSION=3.7.2 \
    SWIG_VERSION=3.0.10 \
    MPI4PY_VERSION=2.0.0 \
    PETSC4PY_VERSION=3.7.0 \
    SLEPC4PY_VERSION=3.7.0 \
    TRILINOS_VERSION=12.6.3 \
    OPENBLAS_NUM_THREADS=1 \
    OPENBLAS_VERBOSE=0

USER root
