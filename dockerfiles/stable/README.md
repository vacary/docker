# FEniCS stable version image

This image provides the most recent stable release of FEniCS
(<http://fenicsproject.org>). The FEniCS installation is installed via
the FEniCS PPA (<https://launchpad.net/~fenics-packages>).

To launch the container:

    docker run -t -i fenicsproject/stable:latest

To share a directory from the host into the container:

    docker run -v /absolute/path/to/directory:/home/fenics/shared -t -i fenicsproject/stable:latest 
