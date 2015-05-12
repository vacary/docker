# Builds a Docker image with FEniCS built from git sources.
# Authors: 
# Lizao Li <lixx1445@umn.edu>
# Jack S. Hale <jack.hale@uni.lu>

FROM fenicsproject/dev:latest
MAINTAINER fenics-project <fenics@fenicsproject.org>

WORKDIR /opt
ADD https://bitbucket.org/fenics-project/fenics-virtual/raw/master/docker/src/fenics.conf /opt/fenics.conf

RUN sed -i 's|FENICS_HOME=/home/fenics/build|FENICS_HOME=/opt/fenics|' /opt/fenics.conf && \
    chmod +r /opt/fenics.conf

RUN /bin/bash -c "source fenics.conf && \
                  update_fenics"

ENV HOME /home/fenics

CMD ["/sbin/my_init"]
