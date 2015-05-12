# Builds a Docker image with the official FEniCS PPA packages installed
# An official build of this Dockerfile is maintaned at:
# https://registry.hub.docker.com/u/fenicsproject/stable-ppa/
# Authors: 
# Lizao Li <lixx1445@umn.edu>
# Jack S. Hale <jack.hale@uni.lu>
FROM phusion/baseimage:latest
MAINTAINER fenics-project <fenics@fenicsproject.org>

# Install add-apt-repository
RUN apt-get -qq update && \
    apt-get -qqy install python-software-properties && \
    add-apt-repository -y ppa:fenics-packages/fenics && \
    apt-get -qq update && \
    apt-get -qqy install xauth fenics ipython xterm && \
    apt-get clean && \ 
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set up user so that we do not run as root
RUN useradd -m -s /bin/bash -G sudo,docker_env fenics && \
    echo "fenics:docker" | chpasswd && \
    echo "fenics ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# See https://github.com/phusion/baseimage-docker/issues/186
RUN touch /etc/service/syslog-forwarder/down

ENV HOME /home/fenics

CMD ["/sbin/my_init"]
