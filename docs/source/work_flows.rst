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

    docker exec -ti project-1 /bin/bash -l

The ``-l`` is important and ensures that your environment in the
container is setup correctly for FEniCS to run. You could also enter
into an ``ipython`` prompt instantly using::

    docker exec -ti project-1 /bin/bash -l -c ipython

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

    docker exec -ti new-project /bin/bash -l

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
  ``$(pwd)`` into the container at ``/home/fenics/shared`` just as before.
* ``-w`` sets the current working directory in the container to our
  shared directory ``/home/fenics/shared``.
* ``"python my-code.py"`` is the command passed to the Docker container. The
  container will immediately execute this command in the working directory. 

In my ``my-code.py`` I have the following simple Python/FEniCS code::

    from dolfin import *
    print "Running FEniCS..."
    mesh = UnitSquareMesh(10, 10)
    V = FunctionSpace(mesh, "CG", 1)
    f = interpolate(Constant(1.0), V)
    File("f.xdmf") << f

Running the ``docker run`` command above then gives me the output::
    
    Running FEniCS...
    Calling FFC just-in-time (JIT) compiler, this may take some time.

and the files ``f.xdmf`` and ``f.h5``  written back onto the host system in the
current working directory.

In practice, there are two (easily fixable!) issues with the above approach;
firstly, on each call to ``docker run`` we get a completely fresh container,
meaning that the `Instant <https://www.bitbucket.org/fenicsproject/instant>`_
cache of compiled objects needs to be regenerated everytime, and secondly the
above command is rather cumbersome to type out.

The first issue can be solved with the concept of `data volume containers`.
Interested users can refer to the official Docker documentation `here
<https://docs.docker.com/engine/userguide/containers/dockervolumes/>`_. In
short, we will create a persistent container that is just used to store
the compiled Instant object cache across individual ``run``-s::

    docker create -v /tmp --name instant-cache quay.io/fenicsproject/stable /bin/true

``create`` is similar to ``run`` but does not actually execute any processes in
the container. This is fine because we will just use the container
``instant-cache`` to store data. We can then mount the contents of ``/tmp``
inside ``instant-cache`` inside a `one-shot` container using the following
command::

    docker run --volumes-from instant-cache --rm -v $(pwd):/home/fenics/shared -w /home/fenics/shared quay.io/fenicsproject/stable "INSTANT_CACHE_DIR=/tmp python my-code.py"

The argument ``--volumes-from instant-cache`` mounts the data volume ``/tmp``
of the ``instant-cache`` container into the `one-shot` container we use to
execute our Python code. If you run the command twice, you will notice on the
second time that we do not need to just-in-time compile the Instant object that
our Python script requires.

The second issue, that the above is cumbersome to write out, can be solved
simply using a shell script. You might want to try putting the following code::

    !/bin/bash
    docker create -v /tmp --name instant-cache quay.io/fenicsproject/stable /bin/true > /dev/null 2>&1
    docker run --volumes-from instant-cache --rm -v $(pwd):/home/fenics/shared -w /home/fenics/shared quay.io/fenicsproject/stable "INSTANT_CACHE_DIR=/tmp $@"

into a file ``fenics`` somewhere in your ``${PATH}`` and making it executable
``chmod +x fenics``. Then you can simply run::

    fenics "python my-code.py"

You could use the ideas in the above script to write your own custom launcher
for FEniCS.

Compile a development version of FEniCS
---------------------------------------

The image ``quay.io/fenicsproject/dev-env`` makes it very easy to compile
a development version of FEniCS, or start contributing to the development
of FEniCS. We cover the latter in :ref:`developing`.

Let's ``run`` the ``dev-env`` image and share the current working directory
into the container at ``/home/fenics/build``::

    docker run -ti -v $(pwd):/home/fenics/build quay.io/fenicsproject/dev-env

You might be surprised how quick it was to download the image ``dev-env``.
This is because the image ``stable`` is actually built on top of the image
``dev-env``. Docker can quickly work out that we have already downloaded all of
the necessary `layers` already when getting the ``stable`` image, and start the
``dev-env`` container almost instantly. 

This environment contains everything we need to compile the latest version of
FEniCS from the ``master`` branch. We provide a helper script ``update_fenics``
that will take care of pulling the source from git, compiling them, and
installing them in the right locations. Using ``update_fenics`` is optional,
you can pull and build FEniCS in anyway you wish inside the container.

For more advanced usage, see :ref:`developing`.

Reproduce my results
--------------------

Whether you are using the ``stable`` image, or have compiled a particular
revision of FEniCS inside a ``dev-env`` container, you might want to make sure
that you can always get back to that specific version at some later date so you
can reproduce your results. Docker makes that easy.

First the simple case; we want to save a particular version of the `stable` image
that will be used for all runs of code in paper-1. We can do this using the
``tag`` directive::

    docker tag quay.io/fenicsproject/stable:latest my-name/fenics-stable:paper-1

Now, even if you decide to pull a newer version of FEniCS stable image::

    docker pull quay.io/fenicsproject/stable:latest

The tag ``my-name/fenicsproject:paper-1`` will *always* point to the version
of FEniCS we have tagged, so when we do::

    docker run -ti my-name/fenics-stable:paper-1

we will get the right version.

In the case we have compiled our own version of FEniCS for paper-2 in a
``dev-env`` image, the steps are slightly more involved. Start with::

    docker run -ti quay.io/fenicsproject/dev-env
    
and in the new container::

    update_fenics

After the compile has finished, ``exit`` the container::

    exit

Now, back on the host, we must ``commit`` the container. This `freezes` the
modifications to the filesystem we made when we compiled FEniCS. Make a note
from your terminal of the unique hash in the bash prompt of the container when
it was running e.g.  `fenics@88794e9fdcf5:~$` and then run, e.g.::

    docker commit 88794

Docker will return a new hash, e.g.::

    sha256:e82475ade54e046e950a7e25c234a9d7d3e77f3ba19062729810a241a50fc8a9

which we can then tag as before::

    docker tag e824 my-name/fenics-dev:paper-2

Note that Docker can auto-complete hashes if you only provide the first few
letters, making typing less cumbersome!

Share my container with a colleague
-----------------------------------

There are two main ways of doing this. The simplest is just to ``save`` your
container in a ``tar`` file and send it to your colleague via your preferred
file transfer method. First off ``exit`` your container and ``commit`` it::

    exit
    docker commit 88794

Docker will return a new hash, e.g.::

    sha256:e82475ade54e046e950a7e25c234a9d7d3e77f3ba19062729810a241a50fc8a9

Now we can ``save`` to a ``tar`` file with::

    docker save e82475 > my-fenics-environment.tar

Send the file ``my-fenics-environment.tar`` to your colleague, and she can load
it into Docker using::

    docker load < my-fenics-environment.tar

and wait for the import to finish. Your colleague can then start the image
using::

    docker run -ti e82475

Of course, they can also ``tag`` the image for easy reference in the future.

The other option is to ``push`` your image up to a cloud service like
`Dockerhub <https://dockerhub.com>`_, or our preferred provider, `quay.io
<https://quay.io>`_. Both of these services will store images for you and allow
others to ``pull`` them, just like our images. 

Once you have an account from one of the above sites, you need to login.


Create a custom image for my team
---------------------------------


