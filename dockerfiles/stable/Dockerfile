# Builds a Docker image with FEniCS stable version built from
# git sources. The image is at:
#
#    https://quay.io/repository/fenicsproject/stable
#
# Authors:
# Jack S. Hale <jack.hale@uni.lu>

FROM quay.io/fenicsproject/dev-env:latest
MAINTAINER fenics-project <fenics-support@googlegroups.com>

USER root 

ENV FENICS_BUILD_TYPE=Release \
    FENICS_VERSION=2016.1.0 \
    FENICS_PREFIX=/usr/local

# Install fenics as root user into /usr/local then remove the fenics-* scripts
# the fenics.env.conf file and the unnecessary /home/fenics/local directory as
# the user does not need them in the stable image! 
RUN /bin/bash -c "FENICS_SRC_DIR=/tmp/src /home/fenics/bin/fenics-pull && \
               FENICS_SRC_DIR=/tmp/src /home/fenics/bin/fenics-build && \
               ldconfig && \
               rm -rf /home/fenics/local && \
               rm -rf /tmp/src && \
               cp -r $FENICS_PREFIX/share/dolfin/demo $FENICS_HOME/demo && \
               rm -rf $FENICS_HOME/bin && \
               echo '' >> $FENICS_HOME/.profile" 

USER fenics
# Make sure we get something that basically works on this stable build.  It
# would be better to run unit tests, but at the moment even the quick tests
# take too long to run.
RUN /bin/bash -l -c "mkdir -p /tmp/poisson_test && \
    cd /tmp/poisson_test && \
    python $FENICS_HOME/demo/documented/poisson/python/demo_poisson.py && \
    instant-clean && \
    rm -r /tmp/poisson_test"

COPY WELCOME $FENICS_HOME/WELCOME

USER root
