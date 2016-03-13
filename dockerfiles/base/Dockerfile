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
# Author:
# Jack S. Hale <jack.hale@uni.lu>

FROM phusion/baseimage:0.9.18
MAINTAINER fenics-project <fenics@fenicsproject.org>

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

USER fenics
ENV HOME /home/fenics

# Print something nice on entry.
COPY WELCOME $HOME/WELCOME

WORKDIR /home/fenics
ENTRYPOINT ["sudo","/sbin/my_init","--quiet","--","sudo","-u","fenics","/bin/bash","-l","-c"]
CMD ["/bin/bash","-i"]
