# This Dockerfile is used by Bamboo https://bamboo.fenicsproject.org to build
# the image:
#
#    https://quay.io/repository/fenicsproject/dev
#
# On a successful build, Bamboo pushes the created image
# to quay.io.
#
# Authors:
# Lizao Li <lzlarryli@gmail.com>
# Jack S. Hale <jack.hale@uni.lu>

FROM quay.io/fenicsproject/dev-env:latest
MAINTAINER fenics-project <fenics-support@googlegroups.com>

USER root

ARG FENICS_BUILD_TYPE
ENV FENICS_BUILD_TYPE ${FENICS_BUILD_TYPE:-Release}
ENV FENICS_SRC_DIR /tmp/src
ENV FENICS_PREFIX /usr/local

RUN bash -l -c "/home/fenics/bin/fenics-pull && \
                PIP_NO_CACHE_DIR=off \
                /home/fenics/bin/fenics-build && \
                ldconfig && \
                rm -rf $FENICS_SRC_DIR"

COPY WELCOME $FENICS_HOME/WELCOME

USER fenics

RUN /bin/bash -l -c "export MPLBACKEND=Agg && \
    mkdir -p /tmp/poisson_test && \
    cd /tmp/poisson_test && \
    python3 $FENICS_PREFIX/share/dolfin/demo/documented/poisson/python/demo_poisson.py && \
    rm -r /tmp/poisson_test"

USER root
