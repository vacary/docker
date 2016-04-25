# Builds a Docker image with FEniCS development versions built from
# git sources for Python 3.
#
# Because FEniCS is not yet fully compatible with Python 3,
# we do not build this image automatically on quay.io.
#
# Authors:
# Lizao Li <lzlarryli@gmail.com>
# Jack S. Hale <jack.hale@uni.lu>
# Johannes Ring <johannr@simula.no>

FROM quay.io/fenicsproject/dev-env-py3:latest
MAINTAINER fenics-project <fenics@fenicsproject.org>

USER fenics

ENV FENICS_PYTHON_MAJOR_VERSION=3 \
    FENICS_PYTHON_MINOR_VERSION=4 \
    FENICS_BUILD_TYPE=Release

RUN /bin/bash -l -c "fenics-update"

COPY WELCOME $FENICS_HOME/WELCOME
