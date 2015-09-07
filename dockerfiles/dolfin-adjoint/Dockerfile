# Builds a Docker image with dolfin-adjoint stable version built from
# git sources. The image is at:
#
#     https://registry.hub.docker.com/u/fenicsproject/
#
# Authors:
# Jack S. Hale <jack.hale@uni.lu>

FROM fenicsproject/stable:latest
MAINTAINER jhale <mail@jackhale.co.uk>

USER fenics
ENV HOME /home/fenics

ENV FENICS_VERSION 1.6.0
ENV DOLFIN_ADJOINT_VERSION 1.6
COPY dolfin-adjoint.conf /home/fenics/dolfin-adjoint.conf
RUN /bin/bash -c "source $HOME/dolfin-adjoint.conf && \
                  update_libadjoint && \
                  update_dolfin-adjoint && \
                  rm -rf $HOME/build/src"

COPY WELCOME $HOME/WELCOME
RUN echo "source $HOME/dolfin-adjoint.conf" >> $HOME/.bashrc

USER root
RUN echo "source $HOME/dolfin-adjoint.conf" >> $HOME/.bashrc.tmp
ENTRYPOINT ["/sbin/my_init","--quiet","--","sudo","-u","fenics","/bin/sh","-c"]
CMD ["/bin/bash --rcfile /home/fenics/.bashrc.tmp"]
