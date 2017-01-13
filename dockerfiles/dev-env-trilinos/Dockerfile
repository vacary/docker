# Builds Trilinos on top of the fenicsproject/dev-env image. Image
# build is available at:
#
#    https://quay.io/repository/fenicsproject/dev-env-trilinos
#
# Author:
# Chris Richardson
FROM quay.io/fenicsproject/dev-env:latest
MAINTAINER fenics-project <fenics-support@googlegroups.com>

USER root
WORKDIR /tmp
RUN wget -nc --quiet http://trilinos.csbsju.edu/download/files/trilinos-${TRILINOS_VERSION}-Source.tar.gz && \
    tar -xf trilinos-${TRILINOS_VERSION}-Source.tar.gz && \
    cd trilinos-${TRILINOS_VERSION}-Source && \
    mkdir build && cd build && \
    cmake -DCMAKE_INSTALL_PREFIX=/usr/local \
          -D TPL_ENABLE_MPI:BOOL=ON \
          -D MPI_CXX_COMPILER:FILEPATH=mpicxx \
          -D MPI_C_COMPILER:FILEPATH=mpicc \
          -D CMAKE_CXX_FLAGS="-O2" \
          -D CMAKE_C_FLAGS="-O2" \
	  -D Trilinos_ENABLE_ROL:BOOL=ON \
	  -D Trilinos_ENABLE_MueLu:BOOL=ON \
          -D Trilinos_ENABLE_Amesos2:BOOL=ON \
          -D Amesos2_ENABLE_KLU2:BOOL=ON \
          -D CMAKE_BUILD_TYPE:STRING=Release \
          -D TPL_ENABLE_Scotch:BOOL=OFF \
          -D TPL_ENABLE_Boost:BOOL=OFF \
          -D Trilinos_ENABLE_EXPLICIT_INSTANTIATION:BOOL=ON \
          -D BUILD_SHARED_LIBS:BOOL=ON \
          -D Trilinos_ENABLE_TESTS:BOOL=OFF \
          -D Trilinos_ENABLE_EXAMPLES:BOOL=OFF \
          -D Amesos2_ENABLE_EXPLICIT_INSTANTIATION:BOOL=ON \
          -D Ifpack2_ENABLE_EXPLICIT_INSTANTIATION:BOOL=ON \
          -D MueLu_ENABLE_EXPLICIT_INSTANTIATION:BOOL=ON \
          -D TpetraCore_ENABLE_EXPLICIT_INSTANTIATION:BOOL=ON \
          -D Tpetra_ENABLE_EXPLICIT_INSTANTIATION:BOOL=ON \
          -D Tpetra_INST_COMPLEX_DOUBLE:BOOL=ON \
          -D Tpetra_INST_DOUBLE:BOOL=ON \
          -D Tpetra_INST_INT_INT:BOOL=ON \
          -D Tpetra_INST_INT_LONG_LONG:BOOL=ON \
          -D Tpetra_INST_SERIAL:BOOL=ON \
          -D Trilinos_ENABLE_EXPLICIT_INSTANTIATION:BOOL=ON \
          -D TpetraCore_ENABLE_EXPLICIT_INSTANTIATION:BOOL=ON \
          -D Xpetra_ENABLE_EXPLICIT_INSTANTIATION:BOOL=ON \
          -D Teuchos_ENABLE_LONG_LONG_INT:BOOL=ON \
          .. && \
    make -j 1 && \
    make install && \
    rm -rf /tmp/*

USER fenics
WORKDIR $FENICS_HOME
COPY WELCOME $FENICS_HOME/WELCOME

USER root
