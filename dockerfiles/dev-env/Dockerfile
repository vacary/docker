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

FROM quay.io/fenicsproject/base:latest
MAINTAINER fenics-project <fenics-support@googlegroups.org>

USER root
WORKDIR /tmp

# Environment variables
ENV PETSC_VERSION=3.7.5 \
    SLEPC_VERSION=3.7.3 \
    SWIG_VERSION=3.0.12 \
    MPI4PY_VERSION=2.0.0 \
    PETSC4PY_VERSION=3.7.0 \
    SLEPC4PY_VERSION=3.7.0 \
    TRILINOS_VERSION=12.10.1 \
    OPENBLAS_NUM_THREADS=1 \
    OPENBLAS_VERBOSE=0 \
    FENICS_PREFIX=$FENICS_HOME/local

# Non-Python utilities and libraries
RUN apt-get -qq update && \
    apt-get -y --with-new-pkgs \
        -o Dpkg::Options::="--force-confold" upgrade && \
    apt-get -y install curl && \
    curl -s https://packagecloud.io/install/repositories/github/git-lfs/script.deb.sh | bash && \
    apt-get -y install \
        bison \
        cmake \
        doxygen \
        flex \
        g++ \
        gfortran \
        git \
        git-lfs \
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
        man \
        wget \
        ccache \
        bash-completion && \
    git lfs install && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Install Python2 based environment
RUN apt-get -qq update && \
    apt-get -y --with-new-pkgs \
        -o Dpkg::Options::="--force-confold" upgrade && \
    apt-get -y install \
        python-dev python3-dev \
        python-flufl.lock python3-flufl.lock \
        python-numpy python3-numpy \
        python-ply python3-ply \
        python-pytest python3-pytest \
        python-scipy python3-scipy \
        python-six python3-six \
        python-subprocess32 \
        python-urllib3  python3-urllib3 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


# Install setuptools
RUN wget https://bootstrap.pypa.io/get-pip.py && \
    python3 get-pip.py && \
    pip3 install --no-cache-dir setuptools && \
    python2 get-pip.py && \
    pip2 install --no-cache-dir setuptools && \
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

# By default use the 32-bit build of SLEPc and PETSc.
ENV SLEPC_DIR=/usr/local/slepc-32 \
    PETSC_DIR=/usr/local/petsc-32

# Install Jupyter, sympy, mpi4py, petsc4py and slepc4py and Swig from source.
RUN pip2 install --no-cache-dir sympy && \
    pip2 install --no-cache-dir matplotlib && \
    pip2 install --no-cache-dir https://bitbucket.org/mpi4py/mpi4py/downloads/mpi4py-${MPI4PY_VERSION}.tar.gz && \
    pip2 install --no-cache-dir https://bitbucket.org/petsc/petsc4py/downloads/petsc4py-${PETSC4PY_VERSION}.tar.gz && \
    pip2 install --no-cache-dir https://bitbucket.org/slepc/slepc4py/downloads/slepc4py-${SLEPC4PY_VERSION}.tar.gz && \
    pip3 install --no-cache-dir jupyter && \
    pip2 install --no-cache-dir ipython ipykernel && \
    python2 -m ipykernel install --prefix=/usr/local && \
    pip3 install --no-cache-dir sympy && \
    pip3 install --no-cache-dir matplotlib && \
    pip3 install --no-cache-dir https://bitbucket.org/mpi4py/mpi4py/downloads/mpi4py-${MPI4PY_VERSION}.tar.gz && \
    pip3 install --no-cache-dir https://bitbucket.org/petsc/petsc4py/downloads/petsc4py-${PETSC4PY_VERSION}.tar.gz && \
    pip3 install --no-cache-dir https://bitbucket.org/slepc/slepc4py/downloads/slepc4py-${SLEPC4PY_VERSION}.tar.gz && \
    wget -nc --quiet http://downloads.sourceforge.net/swig/swig-${SWIG_VERSION}.tar.gz -O swig-${SWIG_VERSION}.tar.gz && \
    tar -xf swig-${SWIG_VERSION}.tar.gz && \
    cd swig-${SWIG_VERSION} && \
    ./configure && \
    make && \
    make install && \
    rm -rf /tmp/*

# Our helper scripts
WORKDIR $FENICS_HOME
COPY fenics.env.conf $FENICS_HOME/fenics.env.conf
COPY bin $FENICS_HOME/bin
RUN PYTHON2_SITE_DIR=$(python2 -c "import site; print(site.getsitepackages()[0])") && \
    PYTHON3_SITE_DIR=$(python3 -c "import site; print(site.getsitepackages()[0])") && \
    PYTHON2_VERSION=$(python2 -c 'import sys; print(str(sys.version_info[0]) + "." + str(sys.version_info[1]))') && \
    PYTHON3_VERSION=$(python3 -c 'import sys; print(str(sys.version_info[0]) + "." + str(sys.version_info[1]))') && \
    echo "$FENICS_HOME/local/lib/python$PYTHON2_VERSION/site-packages" >> $PYTHON2_SITE_DIR/fenics-user.pth && \
    echo "$FENICS_HOME/local/lib/python$PYTHON3_VERSION/site-packages" >> $PYTHON3_SITE_DIR/fenics-user.pth && \
    chown -R fenics:fenics $FENICS_HOME

USER fenics
RUN echo 'source ~/.profile' >> $FENICS_HOME/.bash_profile && \
    echo '. ~/fenics.env.conf' >> $FENICS_HOME/.profile && \
    mkdir -p $FENICS_HOME/.config/matplotlib
COPY matplotlibrc $FENICS_HOME/.config/matplotlib/matplotlibrc
COPY WELCOME $FENICS_HOME/WELCOME

USER root
