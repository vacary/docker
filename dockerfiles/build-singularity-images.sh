#!/bin/bash
# This script can be used to generate Singularity compatible images from the
# Docker images on quay.io.

set -e

for image in dev-env stable
do
    cd ${image}
    IMAGE_NAME=${image}.img
    rm -i ${IMAGE_NAME} || true 
    singularity create --size 2500 ${IMAGE_NAME} 
    echo "Singularity needs sudo to bootstrap images."
    sudo singularity build ${IMAGE_NAME} Singularity
    cd ../
    echo "Created the image ${image}/${IMAGE_NAME}"
done

echo ""
echo "Finished."
echo ""
echo "You can try out a Singularity image with e.g.:"
echo ""
echo "    cd dev-env"
echo "    singularity run -e dev-env.img"
echo ""
echo "For more information see http://singularity.lbl.gov/"
