# Builds a Docker image with the official FEniCS PPA packages installed
# An official build of this Dockerfile is maintaned at:
# https://registry.hub.docker.com/u/fenicsproject/stable-ppa/
# Authors: 
# Lizao Li <lixx1445@umn.edu>
# Jack S. Hale <jack.hale@uni.lu>
FROM phusion/baseimage:0.9.12
MAINTAINER fenics-project <fenics@fenicsproject.org>

ENV HOME /root

# Install add-apt-repository
RUN apt-get -qq update && \
    apt-get -qqy install python-software-properties

# Install the basic environment and fenics from the PPA
RUN add-apt-repository -y ppa:fenics-packages/fenics && \
    apt-get -qq update && \
    apt-get -qqy install xauth fenics ipython

# Cleanup to save space
RUN apt-get clean && \ 
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# Set the HOME environment variable, otherwise import dolfin crashes
RUN echo "/root" > /etc/container_environment/HOME

# Set LIBGL_ALWAYS_INDIRECT to suppress libGL warning message.
RUN echo "y" > /etc/container_environment/LIBGL_ALWAYS_INDIRECT

CMD ["/sbin/my_init"]