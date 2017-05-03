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

USER fenics

ARG FENICS_BUILD_TYPE
ENV FENICS_BUILD_TYPE ${FENICS_BUILD_TYPE:-Release}

# Python 2 build
ENV FENICS_PYTHON=python2

RUN bash -c "source ~/fenics.env.conf && \
             PIP_NO_CACHE_DIR=off fenics-update"

# Python 3 build
ENV FENICS_PYTHON=python3

RUN bash -c "source ~/fenics.env.conf && \
             rm -r /home/fenics/local/src/dolfin/build && \
             PIP_NO_CACHE_DIR=off fenics-build"

COPY WELCOME $FENICS_HOME/WELCOME

USER root
