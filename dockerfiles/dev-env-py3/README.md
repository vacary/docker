# FEniCS development environment image for Python 3

This image provides a development environment for building the FEniCS
libraries for Python 3. It does not provide an installation of
FEniCS. It is intended for users who want to build their own version
of FEniCS. 

To launch the container:

    docker run -t -i quay.io/fenicsproject/dev-env-py3:latest

We do provide a helper script (fenics.conf) in this container to
compile FEniCS automatically:

    update_fenics

If you want to have access to the source code and build files in the
container on the host machine then run:

    docker run -v $(pwd)/build:/home/fenics/build -t -i quay.io/fenicsproject/dev-env-py3:latest

If you would like to have another directory on the host shared into the
container then run:

    docker run -v $(pwd)/shared:/home/fenics/shared -t -i quay.io/fenicsproject/dev-env-py3:latest
