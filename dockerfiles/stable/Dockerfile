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
                     FENICS_VERSION='' fenics-update mshr && \
                     rm -rf $HOME/build/src && \
                     cp -r $HOME/build/share/dolfin/demo $HOME/demo"

# Make sure we get something that basically works on this stable build.  It
# would be better to run unit tests, but at the moment even the quick tests
# take too long to run. 
RUN /bin/bash -l -c "mkdir -p /tmp/poisson_test && \
    cd /tmp/poisson_test && \
    python $HOME/demo/documented/poisson/python/demo_poisson.py && \
    instant-clean && \
    rm -r /tmp/poisson_test"

COPY WELCOME $HOME/WELCOME
