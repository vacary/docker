.. FEniCS Containers documentation master file, created by
   sphinx-quickstart on Sun Mar 13 10:22:20 2016.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

=============================
FEniCS in Containers - Docker
=============================

This is the documentation for Linux/Docker containers for the FEniCS
libraries from the FEniCS Project (http://fenicsproject.org).
Containers provide a consistent and portable FEniCS environment, for
both running FEniCS applications and developing FEniCS. On modern
Linux systems there is no performance penalty when running in a
container compared to running natively on the host system. In many
cases, the container versions of FEniCS are faster than user
installations as the containers have been tuned for performance by the
FEniCS developers. On non-Linux based systems, the containers will run
inside a virtual machine.

The Docker images are automatically built on quay.io at
https://quay.io/repository/fenicsproject/. The Dockerfiles for the
containers are maintained at
https://bitbucket.org/fenics-project/docker. Images are provided of
both release and development versions of FEniCS.

.. toctree::
   :caption: Table of Contents
   :maxdepth: 2


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


Images
======

We currently offer seven end-user images.

Summary
-------

.. |stable| image:: https://quay.io/repository/fenicsproject/stable/status
            :target: https://quay.io/repository/fenicsproject/stable
.. |dolfin-adjoint| image:: https://quay.io/repository/fenicsproject/dolfin-adjoint/status
                    :target: https://quay.io/repository/fenicsproject/dolfin-adjoint
.. |dev| image:: https://quay.io/repository/fenicsproject/dev/status
         :target: https://quay.io/repository/fenicsproject/dev
.. |dev-env| image:: https://quay.io/repository/fenicsproject/dev-env/status
             :target: https://quay.io/repository/fenicsproject/dev-env
.. |dev-env-dbg| image:: https://quay.io/repository/fenicsproject/dev-env-dbg/status
                 :target: https://quay.io/repository/fenicsproject/dev-env-dbg
.. |dev-env-trilinos| image:: https://quay.io/repository/fenicsproject/dev-env-trilinos/status
                      :target: https://quay.io/repository/fenicsproject/dev-env-trilinos
.. |dev-env-py3| image:: https://quay.io/repository/fenicsproject/dev-env-py3/status
                 :target: https://quay.io/repository/fenicsproject/dev-env-py3
.. |dev-py3| image:: https://quay.io/repository/fenicsproject/dev-py3/status
             :target: https://quay.io/repository/fenicsproject/dev-py3
.. |base| image:: https://quay.io/repository/fenicsproject/base/status
          :target: https://quay.io/repository/fenicsproject/base
.. |dev-env-base| image:: https://quay.io/repository/fenicsproject/dev-env-base/status
                  :target: https://quay.io/repository/fenicsproject/dev-env-base

+------------------+---------------------+-----------------------------------------------+
| **Image name**   | **Build status**    | **Short Description**                         |
+------------------+---------------------+-----------------------------------------------+
| stable           | |stable|            | Stable release, with PETSc and SLEPc.         |
+------------------+---------------------+-----------------------------------------------+
| dolfin-adjoint   | |dolfin-adjoint|    | As `stable`, but with dolfin-adjoint.         |
+------------------+---------------------+-----------------------------------------------+
| dev              | |dev|               | Development version.                          |
+------------------+---------------------+-----------------------------------------------+
| dev-env          | |dev-env|           | Development environment with PETSc and SLEPc. |
+------------------+---------------------+-----------------------------------------------+
| dev-env-dbg      | |dev-env-dbg|       | As `dev-env`, but with debugging symbols.     |
+------------------+---------------------+-----------------------------------------------+
| dev-env-trilinos | |dev-env-trilinos|  | As `dev-env`, but with Trilinos.              |
+------------------+---------------------+-----------------------------------------------+
| dev-env-py3      | |dev-env-py3|       | As `dev-env`, but with Python 3.              |
+------------------+---------------------+-----------------------------------------------+
| dev-py3          | |dev-py3|           | As `dev`, but with Python 3.                  |
+------------------+---------------------+-----------------------------------------------+
| base             | |base|              | Base image, not for end users.                |
+------------------+---------------------+-----------------------------------------------+
| dev-env-base     | |dev-env-base|      | Base image, not for end users.                |
+------------------+---------------------+-----------------------------------------------+


Image descriptions
------------------

FEniCS library images
^^^^^^^^^^^^^^^^^^^^^

Application images are designed for typical end-users. Most users are
probably looking for either the `stable` or `dolfin-adjoint` images.

* `stable`: Provides the most recent release of FEniCS and is
  recommended for users who need the latest versions of PETSc, SLEPc,
  petsc4py and slepc4py.

* `dolfin-adjoint`: Identical to stable, but includes dolfin-adjoint_.

.. _dolfin-adjoint: http://dolfin-adjoint.org


Development and advanced images
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Developers and more advanced users may be interested in the following
images:

* `dev`: Provides the latest development version of FEniCS. It is for
  users looking for the latest features.

* `dev-env`: Provides a development environment in which a user can
  compile FEniCS easily. It provides the necessary dependencies for
  FEniCS, but does not provide the FEniCS libraries themselves.

* `dev-env-dbg`: Identical to `dev-env`, except that SLEPc and PETSc
  are compiled with debugging symbols.

* `dev-env-trilinos`: Identical to `dev-env`, except that Trilinos is
  also compiled.

* `dev-env-py3`: Identical to `dev-env`, except with Python 3.

* `dev-py3`: Identical to `dev`, except with Python 3.


Suggested workflows
===================

*This section is currently under construction*.

Docker is an extremely powerful and flexible system for running
containers.  However, with that flexibility comes a steep learning
curve that may raise difficulties for new users. In this section we
cover some common workflows that you might find useful.


Have a separate container for each project
------------------------------------------

We would like to have a separate container for each project.  Let's
say we have two projects located at ``$HOME/project-1`` and
``$HOME/project-2`` on the host. We want `project-1` to use the
``dev`` image with the development version of FEniCS, and `project-2`
to use the ``stable`` image with the stable version of FEniCS. Also we
would like to easily know which container corresponds to which
project.

Then we can run in one terminal::

    cd $HOME/project-1
    docker run -ti --name project-1 -v $(pwd):/home/fenics/shared quay.io/fenicsproject/dev

and in another terminal::

    cd $HOME/project-2
    docker run -ti --name project-2 -v $(pwd):/home/fenics/shared quay.io/fenicsproject/stable

Notice the ``--name`` argument, this allows us to assign an
easy-to-remember name to our container, rather than the ``CONTAINER
ID``. We now have two containers with two different versions of FEniCS
running.


Have multiple shells running in one container
---------------------------------------------

You can get a list of all running containers by running the command::

    docker ps

On my system I have the following output::

    CONTAINER ID        IMAGE                       COMMAND                  CREATED             STATUS              PORTS               NAMES
    ed8960fcf652        quay.io/fenicsproject/dev   "sudo /sbin/my_init -"   3 seconds ago       Up 2 seconds                            project-1

We would like to have another bash container running inside the
container ``project-1``. We can execute a new process in the container
using the ``docker exec`` command::

    docker exec -ti /bin/bash -l

The ``-l`` is important and ensures that your environment in the
container is setup correctly for FEniCS to run. You could also enter
into an ``ipython`` prompt instantly using::

    docker exec -ti /bin/bash -l -c ipython

Restart a finished container
----------------------------

Start a container in the normal way::

    docker run -ti --name new-project -v $(pwd):/home/fenics/shared quay.io/fenicsproject/dev

Now `exit` the container::

    exit

You will be returned to the shell on the host.


Run FEniCS in a Docker container like an application
----------------------------------------------------


Compile a development version of FEniCS
---------------------------------------


Reproduce my results
--------------------


Share my container with a colleague
-----------------------------------


Contribute to the FEniCS Project
--------------------------------


Create a custom image for my team
---------------------------------


Run FEniCS in the cloud
-----------------------


Contact
=======

Support requests can be sent to the FEniCS Support mailing list
(fenics-support@googlegroups.com).

For development-related questions and suggestions, use the FEniCS
Development mailing list (fenics-dev@googlegroups.com). Bugs can be
registered on the Bitbucket Issue Tracker
(https://bitbucket.org/fenics-project/docker/issues).



Indices and tables
==================

* :ref:`genindex`
* :ref:`search`
