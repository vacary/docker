# Builds a Docker image with the stable FEniCS and SSH for MPI.
#
# A build of this Dockerfile is maintaned at:
# https://registry.hub.docker.com/u/fenicsproject/
#
# Authors:
# Lizao Li <lixx1445@umn.edu>

FROM fenicsproject/stable
MAINTAINER fenics-project <fenics@fenicsproject.org>

# Enable SSH
RUN rm -f /etc/service/sshd/down && \
    /etc/my_init.d/00_regen_ssh_host_keys.sh
ADD sshd_config /etc/ssh/sshd_config

ENTRYPOINT ["/sbin/my_init"]


