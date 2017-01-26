#!/bin/bash
# This script can be used to test a complete hierarchy
# of builds on your local machine before pushing up
# to bitbucket for automatic building by quay.io.

set -e
RANDOM_TAG=$RANDOM

# Note: These images do need to be built in a particular order!
# dev-env-trilinos takes so long to compile, I have left it out.
for image in base dev-env stable
do
    cd ${image}
    sed -e "s#quay.io/fenicsproject/${LAST_IMAGE}:latest#quay.io/fenicsproject/${LAST_IMAGE}:${RANDOM_TAG}#g" Dockerfile > Dockerfile.tmp
    docker build --tag quay.io/fenicsproject/${image}:${RANDOM_TAG} -f Dockerfile.tmp .
    LAST_IMAGE=${image}
    rm Dockerfile.tmp
    cd ../
done

echo ""
echo "Finished. A stack of images with the tag $RANDOM_TAG has been built, e.g.:"
echo ""
echo "  docker run -ti quay.io/fenicsproject/stable:${RANDOM_TAG}."
echo ""
echo "These images have not been pushed to quay.io."
