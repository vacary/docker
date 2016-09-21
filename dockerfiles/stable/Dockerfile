# Builds a Docker image with FEniCS stable version built from
# git sources. The image is at:
#
#    https://quay.io/repository/fenicsproject/stable
#
# Authors:
# Jack S. Hale <jack.hale@uni.lu>

FROM quay.io/fenicsproject/dev-env:latest
MAINTAINER fenics-project <fenics-support@googlegroups.com>

USER fenics

ENV FENICS_BUILD_TYPE=Release \
    FENICS_VERSION=2016.1.0 \
    FENICS_PREFIX=/usr/local

RUN /bin/bash -c "source ~/fenics.env.conf && \
                  PIP_NO_CACHE_DIR=off fenics-update && \ 
                  rm -rf $FENICS_PREFIX/src && \
                  cp -r $FENICS_PREFIX/share/dolfin/demo $FENICS_HOME/demo"

# Make sure we get something that basically works on this stable build.  It
# would be better to run unit tests, but at the moment even the quick tests
# take too long to run.
RUN /bin/bash -l -c "mkdir -p /tmp/poisson_test && \
    cd /tmp/poisson_test && \
    python $FENICS_HOME/demo/documented/poisson/python/demo_poisson.py && \
    instant-clean && \
    rm -r /tmp/poisson_test"

COPY WELCOME $FENICS_HOME/WELCOME

USER root
