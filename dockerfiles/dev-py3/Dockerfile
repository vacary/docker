# Builds a Docker image with FEniCS development versions built from
# git sources for Python 3. The image is at:
#
#     https://hub.docker.com/u/fenicsproject/
#
# Authors:
# Lizao Li <lixx1445@umn.edu>
# Jack S. Hale <jack.hale@uni.lu>
# Johannes Ring <johannr@simula.no>

FROM fenicsproject/dev-env-py3:latest
MAINTAINER fenics-project <fenics@fenicsproject.org>

USER fenics

RUN source $HOME/fenics.conf && \
    update_fenics

COPY WELCOME $HOME/WELCOME
