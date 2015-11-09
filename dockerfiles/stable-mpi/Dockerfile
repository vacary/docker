# Builds a Docker image with the stable FEniCS and SSH for MPI. A
# build of this Dockerfile is maintaned at:
#
#    https://hub.docker.com/u/fenicsproject/
#
# Authors:
# Lizao Li <lixx1445@umn.edu>

FROM fenicsproject/stable
MAINTAINER fenics-project <fenics@fenicsproject.org>

# Enable SSH
RUN rm -f /etc/service/sshd/down && \
    /etc/my_init.d/00_regen_ssh_host_keys.sh
ADD sshd_config /etc/ssh/sshd_config

# Change .bashrc so that it still does everything when non-interative
RUN sed -i /home/fenics/.bashrc -e '6s/case/#case/' && \
    sed -i /home/fenics/.bashrc -e '7s/^./#/'       && \
    sed -i /home/fenics/.bashrc -e '8s/^./#/'       && \
    sed -i /home/fenics/.bashrc -e '9s/esac/#esac/'

ENTRYPOINT ["/sbin/my_init"]
