# Builds a Docker image with FEniCS stable version built from
# git sources. The image is at:
#
#     https://hub.docker.com/u/fenicsproject/
#
# Authors:
# Jack S. Hale <jack.hale@uni.lu>

FROM fenicsproject/dev-env:latest
MAINTAINER fenics-project <fenics@fenicsproject.org>

USER fenics

ENV FENICS_PYTHON_MAJOR_VERSION=2 \
    FENICS_PYTHON_MINOR_VERSION=7 \
    FENICS_BUILD_TYPE=Release \
    FENICS_VERSION=1.6.0

RUN /bin/bash -l -c "source $HOME/fenics.conf && \
                     update_fenics && \
                     rm -rf $HOME/build/src"

COPY WELCOME $HOME/WELCOME
