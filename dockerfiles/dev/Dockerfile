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

USER fenics
ENV HOME /home/fenics

RUN /bin/bash -c "source $HOME/fenics.conf && \
                  update_fenics"

COPY WELCOME $HOME/WELCOME

USER root
CMD ["/sbin/my_init"]
ENTRYPOINT exec /sbin/my_init --quiet -- sudo -u fenics /bin/bash --rcfile /home/fenics/.bashrc.tmp
