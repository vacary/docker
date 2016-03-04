# Builds a Docker image with FEniCS stable version built from
# git sources. The image is at:
#
#     https://hub.docker.com/u/fenicsproject/
#
# Authors:
# Jack S. Hale <jack.hale@uni.lu>

FROM fenicsproject/dev-env:latest
MAINTAINER fenics-project <fenics@fenicsproject.org>

USER fenics

ENV FENICS_VERSION 1.6.0
COPY fenics.conf /home/fenics/fenics.conf
RUN source $HOME/fenics.conf && \
    update_fenics && \
    rm -rf $HOME/build/src

COPY WELCOME $HOME/WELCOME
