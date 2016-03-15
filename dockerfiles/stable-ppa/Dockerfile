# Builds a Docker image with the official FEniCS PPA packages
# installed. A build of this Dockerfile is maintaied at:
#
# Note: *Deprecated*, please use quay.io/fenicsproject/stable
#
# Authors:
# Lizao Li <lixx1445@umn.edu>
# Jack S. Hale <jack.hale@uni.lu>

FROM quay.io/fenicsproject/base:latest 
MAINTAINER fenics-project <fenics@fenicsproject.org>

USER root
# Install add-apt-repository
RUN apt-get -qq update && \
    apt-get -qqy install python-software-properties && \
    add-apt-repository -y ppa:fenics-packages/fenics && \
    apt-get -qq update && \
    apt-get -qqy install xauth fenics ipython xterm libopenblas-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY WELCOME $HOME/WELCOME
