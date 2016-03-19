# Builds a Docker image with the necessary libraries for compiling
# FEniCS. PETSc and SLEPc are compiled in debug mode. The image is at:
#
#    https://quay.io/repository/fenicsproject/dev-env-dbg
#
# Authors:
# Jack S. Hale <jack.hale@uni.lu>
# Lizao Li <lixx1445@umn.edu>
# Garth N. Wells <gnw20@cam.ac.uk>

FROM quay.io/fenicsproject/dev-env-base:latest
MAINTAINER fenics-project <fenics@fenicsproject.org>

USER root
RUN echo "2" > /etc/container_environment/FENICS_PYTHON_MAJOR_VERSION
RUN echo "7" > /etc/container_environment/FENICS_PYTHON_MINOR_VERSION

WORKDIR /tmp

# Install Python2 based environment and debuggint tools
RUN apt-get -qq update && \
    apt-get -y install \
         gdb valgrind python-numpy python-six python-ply python-pytest \
         python-h5py python-urllib3 python-setuptools python-pip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install PETSc from source
RUN wget -nc --quiet http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-lite-${PETSC_VERSION}.tar.gz && \
    tar -xf petsc-lite-${PETSC_VERSION}.tar.gz && \
    cd petsc-${PETSC_VERSION} && \
    ./configure --with-blas-lib=/usr/lib/libopenblas.a --with-lapack-lib=/usr/lib/liblapack.a \
                --with-c-support \
                --with-debugging=1 \
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

RUN export PETSC_DIR=/usr/local && \
    wget -nc --quiet http://www.grycap.upv.es/slepc/download/download.php?filename=slepc-${SLEPC_VERSION}.tar.gz -O slepc-${SLEPC_VERSION}.tar.gz && \
    tar -xf slepc-${SLEPC_VERSION}.tar.gz && \
    cd slepc-${SLEPC_VERSION} && \
    ./configure --prefix=/usr/local && \
    make && \
    make install && \
    rm -rf /tmp/*
ENV SLEPC_DIR=/usr/local \
    PETSC_DIR=/usr/local

# Update pip and setuptools, often issues with built-in packages.
RUN pip install --upgrade pip && \
    pip install --upgrade setuptools

# Install sympy, petsc4py, slepc4py and swig from source
RUN pip install sympy && \
    easy_install \
     https://bitbucket.org/petsc/petsc4py/downloads/petsc4py-${PETSC4PY_VERSION}.tar.gz && \
    easy_install \
     https://bitbucket.org/slepc/slepc4py/downloads/slepc4py-${SLEPC4PY_VERSION}.tar.gz && \
    cd /tmp && \
    wget -nc --quiet http://downloads.sourceforge.net/swig/swig-${SWIG_VERSION}.tar.gz && \
    tar xf swig-${SWIG_VERSION}.tar.gz && \
    cd swig-${SWIG_VERSION} && \
    ./configure && \
    make && \
    make install && \
    rm -rf /tmp/*

USER fenics
WORKDIR /home/fenics
COPY WELCOME $HOME/WELCOME
