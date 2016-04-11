# Builds a base Docker image that all other fenicsproject images are
# built off of (FROM). In this image we control the end user
# experience, namely; creating the user fenics, setting up the users
# environment and the default entry point and cmds.
#
# Although this image is not used directly by end-users, it can be
# found at:
#
#   https://quay.io/repository/fenicsproject/base
#
# Authors:
# Jack S. Hale <jack.hale@uni.lu>
# Garth N. Wells <gnw20@cam.ac.uk>

FROM jhale/baseimage:latest 
MAINTAINER fenics-project <fenics@fenicsproject.org>

# Get Ubuntu updates
USER root
RUN apt-get update && \ 
    apt-get upgrade -y -o Dpkg::Options::="--force-confold" && \
    apt-get -y install locales sudo && \
    echo "C.UTF-8 UTF-8" > /etc/locale.gen && \
    locale-gen && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set locale environment
ENV LC_ALL=C.UTF-8 \
    LANG=C.UTF-8 \
    LANGUAGE=C.UTF-8

# Set up user so that we do not run as root
RUN useradd -m -s /bin/bash -G sudo,docker_env fenics && \
    echo "fenics:docker" | chpasswd && \
    echo "fenics ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# OpenBLAS threads should be 1 to ensure performance
RUN echo 1 > /etc/container_environment/OPENBLAS_NUM_THREADS && \
    echo 0 > /etc/container_environment/OPENBLAS_VERBOSE

# See https://github.com/phusion/baseimage-docker/issues/186
RUN touch /etc/service/syslog-forwarder/down
RUN echo "cat /home/fenics/WELCOME" >> /home/fenics/.bashrc

COPY set-home-permissions.sh /etc/my_init.d/set-home-permissions.sh
RUN chmod +x /etc/my_init.d/set-home-permissions.sh

USER fenics
ENV FENICS_HOME /home/fenics

# Print something nice on entry.
COPY WELCOME $FENICS_HOME/WELCOME

WORKDIR /home/fenics
