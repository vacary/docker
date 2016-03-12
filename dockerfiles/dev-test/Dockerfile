# Builds a Docker image with FEniCS development versions built from
# git sources. The image is at:
#
#     https://hub.docker.com/u/fenicsproject/
#
# Authors:
# Lizao Li <lixx1445@umn.edu>
# Jack S. Hale <jack.hale@uni.lu>

FROM quay.io/fenicsproject/dev-env-test:latest
MAINTAINER fenics-project <fenics@fenicsproject.org>

USER fenics

ENV FENICS_PYTHON_MAJOR_VERSION=2 \
    FENICS_PYTHON_MINOR_VERSION=7 \
    FENICS_BUILD_TYPE=Release

RUN bash -l -c "source $HOME/fenics.conf && \
                update_fenics"

COPY WELCOME $HOME/WELCOME
