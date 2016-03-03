# FEniCS development version image for Python 3

This image provides the development version of FEniCS
(<http://fenicsproject.org>) for Python 3. It is intended for users
who want access to the most recent features.

To launch the container:

    docker run -t -i fenicsproject/dev-py3:latest

To share a specified directory from the host with the container:

    docker run -v /absolute/path/to/shared/directory:/home/fenics/shared -t -i fenicsproject/dev-py3:latest
