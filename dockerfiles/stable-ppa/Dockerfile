# Builds a Docker image with the official FEniCS PPA packages
#  installed
#
# A build of this Dockerfile is maintaned at:
# https://registry.hub.docker.com/u/fenicsproject/
#
# Authors:
# Lizao Li <lixx1445@umn.edu>
# Jack S. Hale <jack.hale@uni.lu>
FROM phusion/baseimage:0.9.16
MAINTAINER fenics-project <fenics@fenicsproject.org>

# Install add-apt-repository
RUN apt-get -qq update && \
    apt-get -qqy install python-software-properties && \
    add-apt-repository -y ppa:fenics-packages/fenics && \
    apt-get -qq update && \
    apt-get -qqy install xauth fenics ipython xterm libopenblas-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set up user so that we do not run as root
RUN useradd -m -s /bin/bash -G sudo,docker_env fenics && \
    echo "fenics:docker" | chpasswd && \
    echo "fenics ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# See https://github.com/phusion/baseimage-docker/issues/186
RUN touch /etc/service/syslog-forwarder/down

# OpenBLAS threads should be 1 to ensure performance
RUN echo "export OPENBLAS_NUM_THREADS=1" >> $HOME/.bashrc && \
    echo "export OPENBLAS_VERBOSE=0" >> $HOME/.bashrc

# This makes sure we launch with ENTRYPOINT /bin/bash into the home directory
ENV HOME /home/fenics
ADD WELCOME /home/fenics/WELCOME
RUN cp /home/fenics/.bashrc /home/fenics/.bashrc.tmp && \
    echo "cd $HOME" >> /home/fenics/.bashrc.tmp && \
    echo "cat $HOME/WELCOME" >> /home/fenics/.bashrc.tmp

ENTRYPOINT ["/sbin/my_init","--quiet","--","sudo","-u","fenics","/bin/sh","-c"]
CMD ["/bin/bash --rcfile /home/fenics/.bashrc.tmp"]
