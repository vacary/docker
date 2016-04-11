# Builds a Docker image with the necessary libraries for compiling
# FEniCS for Python 3. The image is at:
#
#    https://quay.io/repository/fenicsproject/dev-env-py3
#
# Authors:
# Jack S. Hale <jack.hale@uni.lu>
# Lizao Li <lzlarryli@gmail.com>
# Garth N. Wells <gnw20@cam.ac.uk>
# Johannes Ring <johannr@simula.no>
# Jan Blechta <blechta@karlin.mff.cuni.cz>

FROM quay.io/fenicsproject/dev-env-base:latest
MAINTAINER fenics-project <fenics@fenicsproject.org>

USER root
RUN echo "3" > /etc/container_environment/FENICS_PYTHON_MAJOR_VERSION
RUN echo "4" > /etc/container_environment/FENICS_PYTHON_MINOR_VERSION

# Install Python3 based environment 
RUN apt-get -qq update && \
    apt-get -y --with-new-pkgs upgrade && \
    apt-get -y install \
        python3-dev python3-numpy python3-six python3-ply python3-pytest \ 
        python3-h5py python3-urllib3 python3-setuptools python3-pip python3-flufl.lock \
        python3-matplotlib && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /tmp
# Install PETSc from source
RUN wget -nc --quiet http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-lite-${PETSC_VERSION}.tar.gz && \
    tar -xf petsc-lite-${PETSC_VERSION}.tar.gz && \
    cd petsc-${PETSC_VERSION} && \
    python2 ./configure --COPTFLAGS="-O2" \
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
RUN export PETSC_DIR=/usr/local && \
    wget -nc --quiet http://www.grycap.upv.es/slepc/download/download.php?filename=slepc-${SLEPC_VERSION}.tar.gz -O slepc-${SLEPC_VERSION}.tar.gz && \
    tar -xf slepc-${SLEPC_VERSION}.tar.gz && \
    cd slepc-${SLEPC_VERSION} && \
    python2 ./configure --prefix=/usr/local && \
    make && \
    make install && \
    rm -rf /tmp/*
ENV SLEPC_DIR=/usr/local \
    PETSC_DIR=/usr/local

RUN pip3 install --upgrade pip && \
    pip3 install --upgrade setuptools

# Install Jupyter, sympy, mpi4py, petsc4py, slepc4py and swig from source
RUN pip3 install jupyter && \
    pip3 install sympy && \
    pip3 install \
     https://bitbucket.org/mpi4py/mpi4py/downloads/mpi4py-${MPI4PY_VERSION}.tar.gz && \
    pip3 install \
     https://bitbucket.org/petsc/petsc4py/downloads/petsc4py-${PETSC4PY_VERSION}.tar.gz && \
    pip3 install \
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
