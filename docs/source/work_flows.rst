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
