# Builds a Docker image with dolfin-adjoint stable version built from
# git sources. The image is at:
#
#    https://quay.io/repository/fenicsproject/dolfin-adjoint
#
# Authors:
# Jack S. Hale <jack.hale@uni.lu>

FROM quay.io/fenicsproject/stable:latest
MAINTAINER jhale <mail@jackhale.co.uk>

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
ENV DOLFIN_ADJOINT_VERSION 1.6
COPY dolfin-adjoint.conf /home/fenics/dolfin-adjoint.conf
RUN /bin/bash -l -c "source $HOME/dolfin-adjoint.conf && \
                     update_libadjoint && \
                     update_dolfin-adjoint && \
                     rm -rf $HOME/build/src"

COPY WELCOME $HOME/WELCOME
RUN echo "source $HOME/dolfin-adjoint.conf" >> $HOME/.bashrc
