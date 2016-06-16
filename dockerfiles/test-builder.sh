#!/bin/bash
# This script can be used to test a complete hierarchy
# of builds on your local machine before pushing up
# to bitbucket for automatic building by quay.io.

set -e

# Note: These images do need to be built in a particular order!
# dev-env-trilinos takes so long to compile, I have left it out.
for image in base dev-env-base dev-env stable dev dev-env-py3 dev-py3 dev-env-dbg
do
    cd ${image}
    docker build --tag quay.io/fenicsproject/${image}:latest .
    cd ../
done
