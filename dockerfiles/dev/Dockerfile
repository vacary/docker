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

RUN bash -l -c "FENICS_SRC_DIR=/tmp/python3 /home/fenics/bin/fenics-pull && \
                FENICS_PREFIX=/usr/local \
                FENICS_PYTHON=python3 \
                FENICS_SRC_DIR=/tmp/python3 \
                PIP_NO_CACHE_DIR=off \
                /home/fenics/bin/fenics-build && \
                ldconfig && \
                rm -rf FENICS_SRC_DIR"

COPY WELCOME $FENICS_HOME/WELCOME

USER root
