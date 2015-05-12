# Builds a Docker image with libraries for compiling FEniCS.
# The image is at:
#     https://registry.hub.docker.com/u/fenicsproject/development
# Authors: 
# Lizao Li <lixx1445@umn.edu>
# Jack S. Hale <jack.hale@uni.lu>

FROM phusion/baseimage:latest
MAINTAINER fenics-project <fenics@fenicsproject.org>

# Install build environment
RUN apt-get -qq update && \
    apt-get -y install \
    	 xauth cmake flex g++ gfortran git ipython openmpi-bin pkg-config \
         subversion wget bison sudo \
         libatlas-base-dev libboost-all-dev libcln-dev libcppunit-dev \
         libeigen3-dev libginac-dev liblapack-dev libmpfr-dev \
         libopenmpi-dev \
         libxml2-dev python-dev libhwloc-dev libvtk5-dev libpcre3-dev \
         libhdf5-openmpi-dev libeigen3-dev libcgal-dev \
         python-numpy python-scientific python-vtk python-six python-ply \
         python-netcdf python-pip xterm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install petsc from source
ENV PETSC_VERSION 3.5.3
RUN cd /tmp && \
    wget -nc http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-${PETSC_VERSION}.tar.gz && \
    tar -xf petsc-${PETSC_VERSION}.tar.gz && \
    cd petsc-${PETSC_VERSION} && \
    ./configure --COPTFLAGS="-O2 -mtune=native -march=native" \
                --CXXOPTFLAGS="-O2 -mtune=native -march=native" \
                --FOPTFLAGS="-O2 -mtune=native -march=native" \
                --with-blas-lib=/usr/lib/libblas.a --with-lapack-lib=/usr/lib/liblapack.a \
                --with-c-support \
                --with-debugging=0 \
                --with-shared-libraries \
                --download-suitesparse \
                --download-scalapack \
                --download-metis \
                --download-parmetis \
                --download-ptscotch \
                --download-hypre \
                --download-mumps \
                --download-blacs \
                --download-spai \
                --download-ml \
                --prefix=/usr/local && \
     make && \
     make install && \
     rm -rf /tmp/*

# Install slepc from source
ENV SLEPC_VERSION 3.5.3
RUN cd /tmp && \
    export PETSC_DIR=/usr/local && \
    wget -nc http://www.grycap.upv.es/slepc/download/download.php?filename=slepc-${SLEPC_VERSION}.tar.gz -O slepc-${SLEPC_VERSION}.tar.gz && \
    tar -xf slepc-${SLEPC_VERSION}.tar.gz && \
    cd slepc-3.5.3 && \
    ./configure --prefix=/usr/local && \
    make && \
    make install && \
    rm -rf /tmp/*
ENV SLEPC_DIR /usr/local
ENV PETSC_DIR /usr/local

# Install sympy, petsc4py, slepc4py, swig from source
ENV SWIG_VERSION 3.0.3
ENV PETSC4PY_VERSION 3.5.1
ENV SLEPC4PY_VERSION 3.5.1
RUN pip install sympy && \
    easy_install \
     https://bitbucket.org/petsc/petsc4py/downloads/petsc4py-${PETSC4PY_VERSION}.tar.gz && \
    easy_install \
     https://bitbucket.org/slepc/slepc4py/downloads/slepc4py-${SLEPC4PY_VERSION}.tar.gz && \
    cd /tmp && \
    wget -nc http://downloads.sourceforge.net/swig/swig-${SWIG_VERSION}.tar.gz && \
    tar xf swig-${SWIG_VERSION}.tar.gz && \
    cd swig-${SWIG_VERSION} && \
    ./configure && \
    make && \
    make install && \
    rm -rf /tmp/*

# Set up user so that we do not run as root
RUN useradd -m -s /bin/bash -G sudo,docker_env fenics && \
    echo "fenics:docker" | chpasswd && \
    echo "fenics ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# See https://github.com/phusion/baseimage-docker/issues/186
RUN touch /etc/service/syslog-forwarder/down

ENV HOME /home/fenics

CMD ["/sbin/my_init"]
