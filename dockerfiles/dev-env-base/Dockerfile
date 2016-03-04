FROM fenicsproject/base:latest
MAINTAINER fenics-project <fenics@fenicsproject.org>

# Our helper script
COPY fenics.conf $HOME/fenics.conf
RUN echo "source $HOME/fenics.conf" >> $HOME/.bashrc

# Version numbers
ENV PETSC_VERSION 3.6.3
ENV SLEPC_VERSION 3.6.2 
ENV SWIG_VERSION 3.0.8
ENV PETSC4PY_VERSION 3.6.0
ENV SLEPC4PY_VERSION 3.6.0
ENV TRILINOS_VERSION 12.4.2
