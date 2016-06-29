#!/bin/bash
# User can pass e.g. --env HOST_UID=1003 so that UID in the container matches
# with the UID on the host. This is useful for Linux users, Mac and Windows
# already do transparent mapping of shared volumes.
if [ "$HOST_UID" ]; then
    usermod -u $HOST_UID fenics
fi
if [ "$HOST_GID" ]; then
    groupmod -g $HOST_GID fenics
fi
# This makes sure that all files in /home/fenics (including any
# shared volumes) are accessible by the user fenics.
chown -R fenics:fenics /home/fenics 2> /dev/null || true
