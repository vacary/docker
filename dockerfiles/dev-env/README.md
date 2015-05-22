# FEniCS development environment image

This image provides a development environment for building the FEniCS
libraries. It does not provide an installation of FEniCS. It is
intended for users who want to build their own version of FEniCS. It
also serves as a base image for
<https://registry.hub.docker.com/u/fenicsproject/dev>, which does
provide the development version of FEniCS.

To launch the container:

    docker run -t -i fenicsproject/dev-env:latest

We do provide a helper script in this container to compile FEniCS
automatically:

    source fenics.conf
    update_fenics

To launch the container and share the current directory on the host
with the container:

    docker run -v $(pwd)/build:/home/fenics/build -t -i fenicsproject/dev-env:latest
