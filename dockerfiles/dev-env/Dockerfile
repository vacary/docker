# Builds a Docker image with the necessary libraries for compiling
# FEniCS.  The image is at:
#
#    https://quay.io/repository/fenicsproject/dev-env
#
# Authors:
# Jack S. Hale <jack.hale@uni.lu>
# Lizao Li <lzlarryli@gmail.com>
# Garth N. Wells <gnw20@cam.ac.uk>
# Jan Blechta <blechta@karlin.mff.cuni.cz>

FROM quay.io/fenicsproject/dev-env-base:latest
MAINTAINER fenics-project <fenics-support@googlegroups.org>

USER root
ENV FENICS_PYTHON_MAJOR_VERSION=2 \
    FENICS_PYTHON_MINOR_VERSION=7

WORKDIR /tmp

# Install Python2 based environment
RUN apt-get -qq update && \
    apt-get -y --with-new-pkgs \
        -o Dpkg::Options::="--force-confold" upgrade && \
    apt-get -y install \
        python-dev \
        python-flufl.lock \
        python-matplotlib \
        python-numpy \
        python-ply \
        python-pytest \
        python-scipy \
        python-six \
        python-urllib3  && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python get-pip.py && \
    pip install --no-cache-dir setuptools && \
    rm -rf /tmp/*

# Install PETSc from source
RUN wget --quiet -nc http://ftp.mcs.anl.gov/pub/petsc/release-snapshots/petsc-lite-${PETSC_VERSION}.tar.gz && \
    tar -xf petsc-lite-${PETSC_VERSION}.tar.gz && \
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
                --prefix=/usr/local/petsc-32 && \
     make && \
     make install && \
    ./configure --COPTFLAGS="-O2" \
                --CXXOPTFLAGS="-O2" \
                --FOPTFLAGS="-O2" \
                --with-64-bit-indices \
                --with-blas-lib=/usr/lib/libopenblas.a --with-lapack-lib=/usr/lib/liblapack.a \
                --with-c-support \
                --with-debugging=0 \
                --with-shared-libraries \
                --download-suitesparse \
                --download-metis \
                --download-parmetis \
                --download-ptscotch \
                --download-hypre \
                --download-superlu_dist \
                --prefix=/usr/local/petsc-64 && \
     make && \
     make install && \
     rm -rf /tmp/*

# Install SLEPc from source
RUN wget -nc --quiet https://bitbucket.org/slepc/slepc/get/v${SLEPC_VERSION}.tar.gz -O slepc-${SLEPC_VERSION}.tar.gz && \
    mkdir -p slepc-src && tar -xf slepc-${SLEPC_VERSION}.tar.gz -C slepc-src --strip-components 1 && \
    export PETSC_DIR=/usr/local/petsc-32 && \
    cd slepc-src && \
    ./configure --prefix=/usr/local/slepc-32 && \
    make && \
    make install && \
    export PETSC_DIR=/usr/local/petsc-64 && \
    ./configure --prefix=/usr/local/slepc-64 && \
    make && \
    make install && \
    rm -rf /tmp/*
ENV SLEPC_DIR=/usr/local/slepc-32 \
    PETSC_DIR=/usr/local/petsc-32

# Install Jupyter, sympy, mpi4py, petsc4py and slepc4py
#  and swig from source
RUN pip install --no-cache-dir jupyter && \
    pip install --no-cache-dir sympy && \
    pip install --no-cache-dir https://bitbucket.org/mpi4py/mpi4py/downloads/mpi4py-${MPI4PY_VERSION}.tar.gz && \
    pip install --no-cache-dir https://bitbucket.org/petsc/petsc4py/downloads/petsc4py-${PETSC4PY_VERSION}.tar.gz && \
    pip install --no-cache-dir https://bitbucket.org/slepc/slepc4py/downloads/slepc4py-${SLEPC4PY_VERSION}.tar.gz && \
    cd /tmp && \
    wget -nc --quiet http://downloads.sourceforge.net/swig/swig-${SWIG_VERSION}.tar.gz && \
    tar xf swig-${SWIG_VERSION}.tar.gz && \
    cd swig-${SWIG_VERSION} && \
    ./configure && \
    make && \
    make install && \
    rm -rf /tmp/*

USER fenics
WORKDIR $FENICS_HOME
COPY WELCOME $FENICS_HOME/WELCOME

USER root
