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
                     rm -rf $FENICS_HOME/build/src && \
                     cp -r $FENICS_HOME/build/share/dolfin/demo $FENICS_HOME/demo"

COPY WELCOME $FENICS_HOME/WELCOME
