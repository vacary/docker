# FEniCS stable version image

This image provides the most recent stable release of FEniCS
(<http://fenicsproject.org>). The FEniCS installation is installed via
the FEniCS PPA (<https://launchpad.net/~fenics-packages>).

To launch the container:

    docker run -t -i fenicsproject/stable:latest

To launch the container and share the current directory on the host
with the container:

    docker run -v $(pwd)/build:/home/fenics/build -t -i fenicsproject/stable:latest

To share a specified directory from the host with the container:

    docker run -v /absolute/path/to/shared/directory:/home/fenics/shared -t -i fenicsproject/stable:latest
