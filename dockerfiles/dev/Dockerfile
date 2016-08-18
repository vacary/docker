# Builds a Docker image with FEniCS development versions built from
# git sources. The image is at:
#
#    https://quay.io/repository/fenicsproject/dev
#
# Authors:
# Lizao Li <lzlarryli@gmail.com>
# Jack S. Hale <jack.hale@uni.lu>

FROM quay.io/fenicsproject/dev-env:latest
MAINTAINER fenics-project <fenics-support@googlegroups.com>

USER fenics

ENV FENICS_BUILD_TYPE=Release

RUN bash -c "source ~/fenics.env.conf && \
             fenics-update"

COPY WELCOME $FENICS_HOME/WELCOME

USER root
