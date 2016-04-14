# Builds a Docker image with FEniCS stable version built from
# git sources. The image is at:
#
#    https://quay.io/repository/fenicsproject/stable
#
# Authors:
# Jack S. Hale <jack.hale@uni.lu>

FROM quay.io/fenicsproject/dev-env:latest
MAINTAINER fenics-project <fenics@fenicsproject.org>

USER fenics

ENV FENICS_PYTHON_MAJOR_VERSION=2 \
    FENICS_PYTHON_MINOR_VERSION=7 \
    FENICS_BUILD_TYPE=Release \
    FENICS_VERSION=1.6.0

RUN /bin/bash -l -c "fenics-update && \
                     fenics-update mshr && \
                     rm -rf $HOME/build/src && \
                     cp -r $HOME/build/share/dolfin/demo $HOME/demo"

COPY WELCOME $HOME/WELCOME
