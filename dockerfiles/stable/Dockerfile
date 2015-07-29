# Builds a Docker image with FEniCS stable version built from
# git sources. The image is at:
#
#     https://registry.hub.docker.com/u/fenicsproject/
#
# Authors:
# Jack S. Hale <jack.hale@uni.lu>

FROM fenicsproject/dev-env:latest
MAINTAINER fenics-project <fenics@fenicsproject.org>

USER fenics
ENV HOME /home/fenics

ENV FENICS_VERSION 1.6.0
COPY fenics.conf /home/fenics/fenics.conf
RUN /bin/bash -c "source $HOME/fenics.conf && \
                  update_fenics && \
                  rm -rf $HOME/build/src"

COPY WELCOME $HOME/WELCOME
USER root
ENTRYPOINT ["/sbin/my_init","--quiet","--","sudo","-u","fenics","/bin/sh","-c"]
CMD ["/bin/bash --rcfile /home/fenics/.bashrc.tmp"]
