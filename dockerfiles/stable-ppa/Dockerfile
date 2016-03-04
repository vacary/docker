# Builds a Docker image with the official FEniCS PPA packages
# installed. A build of this Dockerfile is maintaied at:
#
#    https://hub.docker.com/u/fenicsproject/
#
# Authors:
# Lizao Li <lixx1445@umn.edu>
# Jack S. Hale <jack.hale@uni.lu>

FROM fenicsproject/base:latest 
MAINTAINER fenics-project <fenics@fenicsproject.org>

# Install add-apt-repository
RUN apt-get -qq update && \
    apt-get -qqy install python-software-properties && \
    add-apt-repository -y ppa:fenics-packages/fenics && \
    apt-get -qq update && \
    apt-get -qqy install xauth fenics ipython xterm libopenblas-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

ADD WELCOME $HOME/WELCOME
