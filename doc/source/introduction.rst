.. Description for how to get started with Docker images for FEniCS

.. _introduction:

Introduction
============

.. note:: Want to get up and running quickly? Try the
          ``fenicsproject`` script in :ref:`quickstart`.

Docker allows FEniCS and its dependencies to be packaged into a standard
format for identical deployment almost anywhere. Docker containers are
lightweight and are based on open standards that run on all major Linux
distributions, macOS and Microsoft Windows platforms. For more
information, visit https://www.docker.com/what-docker.


Installing Docker
-----------------

Install Docker by following `these instructions
<https://docs.docker.com/engine/getstarted/step_one/>`_.

If using the Docker Toolbox (macOS versions < 10.10 or Windows versions
< 10), make sure you run all commands inside the Docker Quickstart
Terminal.


Running FEniCS in Docker
------------------------

Under macOS or Windows, start a `Docker Quickstart Terminal`.

For Linux, use a standard terminal. You may need to prepend ``sudo`` to
the commands below. In addition, if you are executing docker via
``fenicsproject`` script, you must prepend it with ``sudo -E``. This
flag allows ``sudo`` to see the enviromental variables, such as
``$FENICS_SRC_DIR``.  To allow ``sudo``-less use, refer to the
installation instructions for your distribution to add your user to the
``docker`` group.

First check that Docker is working::

    docker run hello-world

You should see a message saying that your Docker installation is
working correctly.

.. note:: *Not working?* Check out the :ref:`troubleshooting` section.

To ``pull`` the ``quay.io/fenicsproject/stable`` image::

    docker pull quay.io/fenicsproject/stable:latest

To start FEniCS, run::

    docker run -ti quay.io/fenicsproject/stable:latest

You will be presented with a prompt where you can run FEniCS::

    fenics@0521831b5f28:~$

``fenics`` is your username inside the container and the number
``0521831b5f28`` is the ``CONTAINER ID`` that Docker has assigned.
This ID is *unique* to your computer and this container and will be
different to the one above.

The DOLFIN ``poisson.py`` example can be run using::

    cd ~/demo/documented/poisson/python
    python3 demo_poisson.py

The results will be outputted to the file ``poisson.pvd`` in the same
directory. How to open this file with a visualisation tool is covered in
the next section.


.. _sharing_introduction:

Sharing files from the host into the container
----------------------------------------------

Most users want to continue using the text editor, version control and
other tools already installed on their computers, and just use the
Docker container to run FEniCS.

To share files between the host system and the container, use::

    docker run -ti -v $(pwd):/home/fenics/shared quay.io/fenicsproject/stable

.. note:: Users running Linux distributions with SELinux enabled
   (Redhat, CentOS, Fedora, and others) will need to add the ``:z``
   option to all subsequent host volume mounts ``-v``, e.g.::

       docker run -ti -v $(pwd):/home/fenics/shared:z quay.io/fenicsproject/stable

.. note:: Permissions issues on Linux? Check out the
          :ref:`troubleshooting` section.

This command will ``run`` a new container with the current working
directory ``$(pwd)`` shared with the container at the path
``/home/fenics/shared`` from inside the container.

The syntax for the argument ``-v`` is
``/path/on/host:/path/in/container``.  Note that all paths are
absolute paths.

Now, you can edit your code on the host and run the following inside
the container::

    cd $HOME/shared
    python3 my_code.py

In this case, all files in ``my-work-directory`` will be shared into
the container.  Any files you place in the directory
``/home/fenics/shared`` in the container will be available on the host
system at the current working directory ``$(pwd)``, and vice versa. We
recommend keeping the source code and generated results for your
projects in this shared directory, easily accessible on the host
machine.

Any files placed in *any* other directory than ``/home/fenics/shared``
in the container will *remain* in the container and are not accessible
on the host.


.. _naming_introduction:

Naming a container
------------------

Every container can be given a name so it can be easily referred to it
in the future by passing the ``--name`` flag to the ``docker run``
command, e.g.::

    docker run -ti -v $(pwd):/home/fenics/shared --name fenics-container quay.io/fenicsproject/stable

The container can be be stopped and started::

    docker stop fenics-container
    docker start fenics-container
    docker exec -ti -u fenics fenics-container /bin/bash -l

To see the name and other information of every container you have ever
created::

    docker ps -a

To see the information of only running containers::

    docker ps

For more details on ways of working with Docker and FEniCS, check out
:ref:`workflows`.
