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

ENV FENICS_BUILD_TYPE=Release

RUN bash -c "source ~/fenics.env.conf && \
             PIP_NO_CACHE_DIR=off fenics-update"

COPY WELCOME $FENICS_HOME/WELCOME

USER root
