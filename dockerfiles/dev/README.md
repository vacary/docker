# FEniCS development version image

This image provides the development version of FEniCS
(<http://fenicsproject.org>). It is intended for users who want access
to the most recent features.

To launch the container:

    docker run -t -i quay.io/fenicsproject/dev:latest

To share a specified directory from the host with the container:

    docker run -v /absolute/path/to/shared/directory:/home/fenics/shared -t -i quay.io/fenicsproject/dev:latest
