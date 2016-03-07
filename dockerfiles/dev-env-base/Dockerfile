# Shim image that adds in the global fenics.conf used by all and allows easy
# bumping of package versions using one set of environment variables.
#
# Author:
# Jack S. Hale <jack.hale@uni.lu>

FROM fenicsproject/base:latest
MAINTAINER fenics-project <fenics@fenicsproject.org>

# Our helper script
USER root
COPY fenics.conf $HOME/fenics.conf
RUN chown fenics:fenics $HOME/fenics.conf && \
    chmod u+rw $HOME/fenics.conf

USER fenics
RUN echo "source $HOME/fenics.conf" >> $HOME/.bashrc

# Version numbers
ENV PETSC_VERSION=3.6.3 \
    SLEPC_VERSION=3.6.2 \
    SWIG_VERSION=3.0.8 \
    PETSC4PY_VERSION=3.6.0 \
    SLEPC4PY_VERSION=3.6.0 \
    TRILINOS_VERSION=12.4.2
