#!/bin/bash
# This script can be used to test a complete hierarchy
# of builds on your local machine before pushing up
# to bitbucket for automatic building by dockerhub.

# Note: These images do need to be built in a particular order!
for image in base dev-env-base dev-env stable dev dev-env-dbg dev-env-py3 dev-py3 dolfin-adjoint stable-ppa 
do
    cd ${image}
    docker build --tag fenicsproject/${image}:latest .
    cd ../
done
