.. Documentation for suggested work flows using Docker

Suggested workflows
===================

*This section is currently under construction*.

Docker is an extremely powerful and flexible system for running
containers.  However, with that flexibility comes a steep learning
curve that may raise difficulties for new users. In this section we
cover some common workflows that you might find useful.

Advanced users may find the `Docker Cheat Sheet
<https://github.com/wsargent/docker-cheat-sheet>`_ useful for quick reference.

Separate container for each user project
----------------------------------------

We would like to have a separate container for each user project.  Say
we have two projects located at ``$HOME/project-1`` and
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


Multiple shells running in one container
----------------------------------------

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

Restart an exited container
---------------------------

Start a container in the normal way::

    docker run -ti --name new-project -v $(pwd):/home/fenics/shared quay.io/fenicsproject/dev

Now ``exit`` the bash shell in the container::

    exit

You will be returned to the shell on the host system. By default, when you
``exit`` the running process the container is stopped, but not deleted. All of
the data associated with the container ``new-project`` remains on your system.
This means we can restart this container right where we left it.

We can see a list of all running and stopped containers using the command::

    docker ps -a

On my system I have the following output::

    CONTAINER ID        IMAGE                                           COMMAND                   CREATED             STATUS                         PORTS               NAMES
    143043b0fdfd        quay.io/fenicsproject/dev                       "sudo /sbin/my_init -"    9 seconds ago       Exited (0) 1 seconds ago                           new-project

You may need to scroll the above code box to the right to see the ``NAMES`` field
where you will see the recently exited container ``new-project``.

To ``start`` the container ``new-project`` again simply run the command::

    docker start new-project

We can make a new shell in the container using the command::

    docker exec -ti /bin/bash -l

Conversely, you can stop a running container using the command::

    docker stop new-project

Run FEniCS in a Docker container like an application
----------------------------------------------------

You don't have to run FEniCS by starting a shell in Docker and running
``python`` to execute your FEniCS scripts. It is also possible to execute
any executable directly in the container from the ``docker run`` command.

Say we have a python file ``my-code.py`` in the current working directory on
the host and that we want to run ``python`` on it directly within a `one-shot`
FEniCS container. We can do this with the following command::

    docker run --rm -v $(pwd):/home/fenics/shared -w /home/fenics/shared quay.io/fenicsproject/stable "python my-code.py"

Let's break this complex ``run`` command down flag-by-flag:

* ``--rm`` means that Docker will remove the container immediately after
  exiting the container. Old and unused containers won't clutter up your
  machine. 
* ``-v $(pwd):/home/fenics/shared`` shares the current working directory
  `$(pwd)` into the container at `/home/fenics/shared`.
* ``-w`` sets the current working directory in the container to our
  shared directory ``/home/fenics/shared``.
* ``"python my-code.py"`` is the command passed to the Docker container. The
  container will immediately execute this command. 

In my ``my-code.py`` I have the following simple Python/FEniCS code::

    from dolfin import *
    mesh = UnitSquareMesh(10, 10)
    V = FunctionSpace(mesh, "CG", 1)


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
