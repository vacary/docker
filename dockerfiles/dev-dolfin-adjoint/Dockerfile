# Builds a Docker image with dolfin-adjoint stable version built from
# git sources. The image is at:
#
#    https://quay.io/repository/fenicsproject/dev-dolfin-adjoint
#
# Authors:
# Simon W. Funke <simon@simula.no>

FROM quay.io/fenicsproject/dev:latest
MAINTAINER Simon W. Funke <simon@simula.no>

USER root
RUN apt-get -qq update && \
    apt-get -y install python-scipy && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN git clone https://github.com/funsim/moola.git && \
    cd moola && \
    python setup.py install && \
    rm -rf /tmp/*

USER fenics
ENV DOLFIN_ADJOINT_VERSION master
COPY dolfin-adjoint.conf $FENICS_HOME/dolfin-adjoint.conf
RUN /bin/bash -l -c "source $FENICS_HOME/dolfin-adjoint.conf && \
                     update_libadjoint && \
                     update_dolfin-adjoint && \
                     rm -rf $FENICS_HOME/build/src"

COPY WELCOME $FENICS_HOME/WELCOME
RUN echo "source $FENICS_HOME/dolfin-adjoint.conf" >> $FENICS_HOME/.bash_profile
