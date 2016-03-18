.. Description for how to get started with Docker images for FEniCS

Getting started
===============


What is Docker?
---------------

Docker allows us to package FEniCS and all of its complex dependencies
into a standard format for identical deployment almost anywhere; your
laptop, the cloud, or in high-performance computing environments.

Docker containers are extremely lightweight, secure, and are based on
open standards that run on all major Linux distributions, Mac OS X and
Microsoft Windows platforms.

For more information, visit https://www.docker.com/what-docker.

Installing Docker
-----------------

Mac and Windows users should install the `Docker Toolbox <https://www.docker.com/products/docker-toolbox>`_ and Linux
users should follow `these instructions <https://docs.docker.com/engine/installation/linux/>`_.

For a full list of platforms and installation options, see
the instructions `here <https://docs.docker.com/engine/installation/>`_.

Running FEniCS in Docker
------------------------

If running on Mac or Windows, start a `Docker Quickstart Terminal`. This can
take a little while the first time so just be patient.

If you are running on Linux, just use a standard terminal session. Note that
you will need to prepend ``sudo`` to the commands below. To allow ``sudo``-less
use, refer to the installation instructions for your distribution to add your
user to the ``docker`` group.

First of all we will check that we have a working install of Docker::

    docker run hello-world

You should see a message saying that your Docker installation is working
correctly.

Now we will ``pull`` the ``quay.io/fenicsproject/stable`` image from
our cloud infrastructure::

    docker pull quay.io/fenicsproject/stable:latest

Docker will ``pull`` the ``latest`` tag of the image
``fenicsproject/stable`` from ``quay.io``. The download is around
1.3GB. The ``stable`` image is a great place to start experimenting
with FEniCS and includes PETSc, SLEPc, slepc4py, petsc4py, MPI, HDF5
and many other difficult dependencies already compiled for you.

Once the download is complete you can start FEniCS for the first
time. Just run::

    docker run -ti quay.io/fenicsproject/stable:latest

Docker will ``run`` the image we have just ``pull``-ed.

You will be presented with a bash prompt where you can run FEniCS::

    fenics@0521831b5f28:~$

``fenics`` is your username inside the container and the number
``0521831b5f28`` is the ``CONTAINER ID`` that Docker has assigned.
This ID is *unique* to your computer and this container and will be
different to the one above.

We can run the standard DOLFIN ``poisson.py`` example as usual::

    cp /usr/share/dolfin/demo/documented/poisson/python/demo_poisson.py $HOME
    python demo_poisson.py

You should see the following output::

    Calling FFC just-in-time (JIT) compiler, this may take some time.
    Calling DOLFIN just-in-time (JIT) compiler, this may take some time.
    Calling DOLFIN just-in-time (JIT) compiler, this may take some time.
    Calling FFC just-in-time (JIT) compiler, this may take some time.
    Calling FFC just-in-time (JIT) compiler, this may take some time.
    Solving linear variational problem.
    *** Warning: Plotting not available. DOLFIN has been compiled without VTK support.

The results will be outputted to the file ``poisson.pvd`` in the same
directory. It would now be useful to have this file on the host system
for visualisation with e.g. Paraview. How to do this is the subject of
the next section.


Sharing files from the host into the container
----------------------------------------------

Most users want to continue using the text editor, version control and
other tools already installed on their computers, and just use the
Docker container to run FEniCS.

To facilitate this, it is useful to be able to share files from the
host system into the container by passing ``-v`` argument to the
``docker run`` command::

    docker run -ti -v $(pwd):/home/fenics/shared quay.io/fenicsproject/stable

This ``run``-s a new container with the current working directory
``$(pwd)`` shared into the container at the path
``/home/fenics/shared``.

The syntax for the argument ``-v`` is
``/path/on/host:/path/in/container``. Note that all paths are absolute
paths.

Now, you can edit your code on the host and simply::

    cd $HOME/shared
    python my_code.py

in the container. Any results written by ``my_code.py`` will be
instantly available back on the host machine in ``$(pwd)``.
