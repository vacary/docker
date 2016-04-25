# Builds a Docker image with FEniCS development versions built from
# git sources. The image is at:
#
#    https://quay.io/repository/fenicsproject/dev
#
# Authors:
# Lizao Li <lzlarryli@gmail.com>
# Jack S. Hale <jack.hale@uni.lu>

FROM quay.io/fenicsproject/dev-env:latest
MAINTAINER fenics-project <fenics@fenicsproject.org>

USER fenics

ENV FENICS_PYTHON_MAJOR_VERSION=2 \
    FENICS_PYTHON_MINOR_VERSION=7 \
    FENICS_BUILD_TYPE=Release

RUN bash -l -c "fenics-update"

COPY WELCOME $FENICS_HOME/WELCOME
