# Builds a Docker image with the necessary libraries for compiling
# FEniCS.  The image is at:
#
#     https://registry.hub.docker.com/u/fenicsproject/
#
# Authors:
# Jack S. Hale <jack.hale@uni.lu>
# Lizao Li <lixx1445@umn.edu>
# Garth N. Wells <gnw20@cam.ac.uk>

FROM phusion/baseimage:0.9.16
MAINTAINER fenics-project <fenics@fenicsproject.org>

# Install build environment
RUN apt-get -qq update && \
    apt-get -y install \
    	 xauth cmake flex g++ gfortran git ipython openmpi-bin pkg-config \
         wget bison sudo \
         libopenblas-dev libboost-all-dev libcln-dev libcppunit-dev \
         libeigen3-dev liblapack-dev libmpfr-dev \
         libopenmpi-dev \
         python-dev libhwloc-dev libvtk6-dev libpcre3-dev \
         libhdf5-openmpi-dev libeigen3-dev libcgal-dev \
         python-numpy python-vtk6 python-six python-ply \
         python-h5py python-urllib3 xterm && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install PETSc from source
ENV PETSC_VERSION 3.6.0
RUN cd /tmp && \
    wget -nc http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-${PETSC_VERSION}.tar.gz && \
    tar -xf petsc-${PETSC_VERSION}.tar.gz && \
    cd petsc-${PETSC_VERSION} && \
    ./configure --COPTFLAGS="-O2" \
                --CXXOPTFLAGS="-O2" \
                --FOPTFLAGS="-O2" \
                --with-blas-lib=/usr/lib/libopenblas.a --with-lapack-lib=/usr/lib/liblapack.a \
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

# Install SLEPc from source
ENV SLEPC_VERSION 3.6.0
RUN cd /tmp && \
    export PETSC_DIR=/usr/local && \
    wget -nc http://www.grycap.upv.es/slepc/download/download.php?filename=slepc-${SLEPC_VERSION}.tar.gz -O slepc-${SLEPC_VERSION}.tar.gz && \
    tar -xf slepc-${SLEPC_VERSION}.tar.gz && \
    cd slepc-${SLEPC_VERSION} && \
    ./configure --prefix=/usr/local && \
    make && \
    make install && \
    rm -rf /tmp/*
ENV SLEPC_DIR /usr/local
ENV PETSC_DIR /usr/local

# Install Python setuptools and pip (the Ubuntu 14.04 packaged
#  versions have bugs that cause failures when installing FEniCS
#  Python packages)
RUN wget https://bootstrap.pypa.io/ez_setup.py -O - | python && \
    easy_install pip

# Install sympy, petsc4py, slepc4py and swig from source
ENV SWIG_VERSION 3.0.5
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

# Our helper script
COPY fenics.conf $HOME/fenics.conf
# and the README
COPY WELCOME $HOME/WELCOME
RUN chown fenics:fenics $HOME/WELCOME && \
    chown fenics:fenics $HOME/fenics.conf && \
    chmod u+rw $HOME/WELCOME && \
    chmod u+rw $HOME/fenics.conf

# OpenBLAS threads should be 1 to ensure performance
RUN echo "export OPENBLAS_NUM_THREADS=1" >> $HOME/.bashrc && \
    echo "export OPENBLAS_VERBOSE=0" >> $HOME/.bashrc

# This makes sure we launch with ENTRYPOINT /bin/bash into the home directory
RUN echo "source $HOME/fenics.conf" >> $HOME/.bashrc && \
    cp $HOME/.bashrc $HOME/.bashrc.tmp && \
    echo "cd $HOME" >> $HOME/.bashrc.tmp && \
    echo "cat $HOME/WELCOME" >> $HOME/.bashrc.tmp

ENTRYPOINT ["/sbin/my_init","--quiet","--","sudo","-u","fenics","/bin/sh","-c"]
CMD ["/bin/bash --rcfile /home/fenics/.bashrc.tmp"]
