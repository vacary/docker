# Builds a Docker image with FEniCS development versions built from
# git sources. The image is at:
#
#     https://registry.hub.docker.com/u/fenicsproject/
#
# Authors:
# Lizao Li <lixx1445@umn.edu>
# Jack S. Hale <jack.hale@uni.lu>

FROM fenicsproject/dev-env:latest
MAINTAINER fenics-project <fenics@fenicsproject.org>

WORKDIR /opt
ADD https://raw.githubusercontent.com/FEniCS/docker/master/fenics.conf /opt/fenics.conf

RUN sed -i 's|FENICS_HOME=/home/fenics/build|FENICS_HOME=/opt/fenics|' /opt/fenics.conf && \
    chmod +r /opt/fenics.conf

RUN /bin/bash -c "source fenics.conf && \
                  update_fenics"

ENV HOME /home/fenics

CMD ["/sbin/my_init"]
