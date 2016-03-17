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

For more information, visit: https://www.docker.com/what-docker

.. Compared to virtual machines, Docker containers have a different architecture
.. allowing them to be much more lightweight. In the contect of scientific
.. computing we have found that:

.. * You can have hundreds of Docker containers on one laptop, with almost no
..  performance overhead.
.. * New containers take microseconds to start up.
.. * On Linux-based platforms, there is *no* measurable performance penalty
..  compared to a natively compiled version of FEniCS. On platforms where Docker
..  runs inside a Virtual Machine, performance overhead is only around ten
..  percent.
.. * It is easy and convienient to share development platforms with colleagues.
.. * Like a commit in version control systems such as git, each Docker image has a
..  unique mathematical hash associated with it. This makes it much easier to
..  reproduce results for papers.


Installing Docker
-----------------

To install Docker for your platform (Windows, Mac OS X, Linux), follow
the instructions at https://docs.docker.com/engine/installation/.

Windows and Mac OS X users will also find the following information on
using Docker Machine useful:
https://docs.docker.com/machine/get-started/


Running FEniCS in Docker
------------------------

You need to open a Terminal on your platform. Windows users can start
the Command Prompt (``cmd.exe``).

First of all we will check that we have a working install of Docker::

    docker info

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
