.. Documentation for suggested work flows using Docker

.. _workflows:

Suggested workflows
===================

Docker is an extremely powerful and flexible system for running
containers.  However, with that flexibility comes a steep learning
curve that may raise difficulties for new users. In this section we
cover some common workflows that you might find useful.

Advanced users may find the `Docker Cheat Sheet
<https://github.com/wsargent/docker-cheat-sheet>`_ useful for quick
reference.

.. _seperate-container:

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

    docker exec -ti -u fenics project-1 /bin/bash -l

The ``-l`` is important and ensures that your environment in the
container is setup correctly for FEniCS to run. You could also enter
into an ``ipython`` prompt instantly using::

    docker exec -ti -u fenics project-1 /bin/bash -l -c ipython

The ``-c`` flag makes ``bash`` read the commands from the string.

.. _exited-container:

Restart an exited container
---------------------------

Start a container in the normal way::

    docker run -ti --name new-project -v $(pwd):/home/fenics/shared quay.io/fenicsproject/dev

Now ``exit`` the bash shell in the container::

    exit

You will be returned to the shell on the host system. By default, when
you ``exit`` the running process the container is stopped, but not
deleted. All of the data associated with the container ``new-project``
remains on your system.  This means we can restart this container
right where we left it.

We can see a list of all running and stopped containers using the
command::

    docker ps -a

On my system I have the following output::

    CONTAINER ID        IMAGE                                           COMMAND                   CREATED             STATUS                         PORTS               NAMES
    143043b0fdfd        quay.io/fenicsproject/dev                       "sudo /sbin/my_init -"    9 seconds ago       Exited (0) 1 seconds ago                           new-project

You may need to scroll the above code box to the right to see the
``NAMES`` field where you will see the recently exited container
``new-project``.

To ``start`` the container ``new-project`` again simply run the
command::

    docker start new-project

We can make a new shell in the container using the command::

    docker exec -ti new-project -u fenics /bin/bash -l

Conversely, you can stop a running container using the command::

    docker stop new-project


Run FEniCS in a Docker container like an application
----------------------------------------------------

You don't have to run FEniCS by starting a shell in Docker and running
``python`` to execute your FEniCS scripts. It is also possible to
execute any executable directly in the container from the ``docker
run`` command.

Say we have a python file ``my-code.py`` in the current working
directory on the host and that we want to run ``python`` on it
directly within a `one-shot` FEniCS container. We can do this with the
following command::

    docker run --rm -v $(pwd):/home/fenics/shared -w /home/fenics/shared quay.io/fenicsproject/stable "python my-code.py"

Let's break this complex ``run`` command down flag-by-flag:

* ``--rm`` means that Docker will remove the container immediately
  after exiting the container. Old and unused containers won't clutter
  up your machine.
* ``-v $(pwd):/home/fenics/shared`` shares the current working
  directory ``$(pwd)`` into the container at ``/home/fenics/shared``
  just as before.
* ``-w`` sets the current working directory in the container to our
  shared directory ``/home/fenics/shared``.
* ``"python my-code.py"`` is the command passed to the Docker
  container. The container will immediately execute this command in
  the working directory.

In my ``my-code.py`` I have the following simple Python/FEniCS code::

    from dolfin import *
    print "Running FEniCS..."
    mesh = UnitSquareMesh(10, 10)
    V = FunctionSpace(mesh, "CG", 1)
    f = interpolate(Constant(1.0), V)
    XDMFFile("f.xdmf").write(f)

Running the ``docker run`` command above then gives me the output::

    Running FEniCS...
    Calling FFC just-in-time (JIT) compiler, this may take some time.

and the files ``f.xdmf`` and ``f.h5`` written back onto the host
system in the current working directory.

In practice, there are two (easily fixable!) issues with the above
approach; firstly, on each call to ``docker run`` we get a completely
fresh container, meaning that the `Instant
<https://www.bitbucket.org/fenicsproject/instant>`_ cache of compiled
objects needs to be regenerated everytime, and secondly the above
command is rather cumbersome to type out.

The first issue can be solved with the concept of `data volume
containers`.  Interested users can refer to the official Docker
documentation `here
<https://docs.docker.com/engine/userguide/containers/dockervolumes/>`_. In
short, we will create a persistent Docker volume that is just used to
store the compiled Instant object cache across individual ``run``-s::

    docker volume create --name instant-cache

We can then mount the persistent ``instant-cache`` image inside a `one-shot`
container using the following command::

    docker run --rm -v instant-cache:/home/fenics/.instant -v $(pwd):/home/fenics/shared -w /home/fenics/shared quay.io/fenicsproject/stable "python my-code.py"

The argument ``-v instant-cache:/home/fenics/.instant`` mounts the data volume
``instant-cache`` container into the `one-shot`
container we use to execute our Python code. If you run the command
twice, you will notice on the second time that we do not need to
just-in-time compile the Instant object that our Python script
requires, because the cache is now stored inside the Docker volume.

The second issue, that the above is cumbersome to write out, can be
solved simply using a shell script. You might want to try putting the
following code::

    !/bin/bash
    docker volume create --name instant-cache > /dev/null 2>&1
    docker run --rm -v instant-cache:/home/fenics/.instant -v $(pwd):/home/fenics/shared -w /home/fenics/shared quay.io/fenicsproject/stable "$@"

into a file ``fenics`` somewhere in your ``${PATH}`` and making it
executable ``chmod +x fenics``. Then you can simply run::

    fenics "python my-code.py"

You could use the ideas in the above script to write your own custom
launcher for FEniCS.


Compile a development version of FEniCS
---------------------------------------

The image ``quay.io/fenicsproject/dev-env`` makes it very easy to
compile a development version of FEniCS, or start contributing to the
development of FEniCS. We cover the latter in :ref:`developing`.

Let's ``run`` the ``dev-env`` image and share the current working
directory into the container at ``/home/fenics/build``::

    docker run -ti -v $(pwd):/home/fenics/build quay.io/fenicsproject/dev-env

You might be surprised how quick it was to download the image
``dev-env``.  This is because the image ``stable`` is actually built
on top of the image ``dev-env``. Docker can quickly work out that we
have already downloaded all of the necessary `layers` already when
getting the ``stable`` image, and start the ``dev-env`` container
almost instantly.

This environment contains everything we need to compile the latest
version of FEniCS from the ``master`` branch. We provide a helper
script ``fenics-update`` that will take care of pulling the source
from git, compiling them, and installing them in the right
locations. Using ``fenics-update`` is optional, you can pull and build
FEniCS in anyway you wish inside the container.

For more advanced usage, see :ref:`developing`.


Reproduce my results
--------------------

Whether you are using the ``stable`` image, or have compiled a
particular revision of FEniCS inside a ``dev-env`` container, you
might want to make sure that you can always get back to that specific
version at some later date so you can reproduce your results. Docker
makes that easy.

First the simple case; we want to save a particular version of the
`stable` image that will be used for all runs of code in paper-1. We
can do this using the ``tag`` directive::

    docker tag quay.io/fenicsproject/stable:latest my-name/fenics-stable:paper-1

Now, even if you decide to pull a newer version of FEniCS stable
image::

    docker pull quay.io/fenicsproject/stable:latest

The tag ``my-name/fenicsproject:paper-1`` will *always* point to the
version of FEniCS we have tagged, so when we do::

    docker run -ti my-name/fenics-stable:paper-1

we will get the right version.

In the case we have compiled our own version of FEniCS for paper-2 in
a ``dev-env`` image, the steps are slightly more involved. Start
with::

    docker run -ti quay.io/fenicsproject/dev-env

and in the new container::

    fenics-update

After the compile has finished, ``exit`` the container::

    exit

Now, back on the host, we must ``commit`` the container. This
`freezes` the modifications to the filesystem we made when we compiled
FEniCS. Make a note from your terminal of the unique hash in the bash
prompt of the container when it was running e.g.
``fenics@88794e9fdcf5:~$`` and then run, e.g.::

    docker commit 88794

Docker will return a new hash, e.g.::

    sha256:e82475ade54e046e950a7e25c234a9d7d3e77f3ba19062729810a241a50fc8a9

which we can then tag as before::

    docker tag e824 my-name/fenics-dev:paper-2

Note that Docker can auto-complete hashes if you only provide the
first few letters, making typing less cumbersome!


Share my container with a colleague
-----------------------------------

There are two main ways of doing this. The simplest is just to
``save`` your container in a ``tar`` file and send it to your
colleague via your preferred file transfer method. First off ``exit``
your container and ``commit`` it::

    exit
    docker commit 88794

Docker will return a new hash, e.g.::

    sha256:e82475ade54e046e950a7e25c234a9d7d3e77f3ba19062729810a241a50fc8a9

Now we can ``save`` to a ``tar`` file with::

    docker save e82475 > my-fenics-environment.tar

Send the file ``my-fenics-environment.tar`` to your colleague, and she
can load it into Docker using::

    docker load < my-fenics-environment.tar

and wait for the import to finish. Your colleague can then start the
image using::

    docker run -ti e82475

Of course, your colleague can also ``tag`` the image for easy reference in the
future.

The other option is to ``push`` your image up to a cloud repository like
`Dockerhub <https://dockerhub.com>`_, or our preferred provider, `quay.io
<https://quay.io>`_. Both of these services will store images for you and allow
others to ``pull`` them, just like our images.

First get an account on `Dockerhub <https://dockerhub.com>`_ or `quay.io
<https://quay.io>`_.

In the case that you have chosen quay.io you need to login using
``docker login`` and the URL of the quay.io repository::

    docker login https://quay.io/v2/

In the case you have chosen Dockerhub, you can login without specifying
a URL as Dockerhub is the default repository::

    docker login

Then, you can push your image to the remote repository using
``docker tag`` and ``docker push``::

    docker tag e82475 quay.io/my-user/test-repo:latest
    docker push quay.io/my-user/test-repo:latest

``quay.io`` is the remote repository I want to push to, ``my-user`` is my
username on quay.io and ``test-repo`` is the name of the repository I want to
create. Dockerhub users can leave off the ``quay.io/`` prefix as Dockerhub is
the default remote repository.

Once the upload is complete anyone can ``pull`` your image from
the repository::

    docker pull quay.io/my-user/test-repo

and ``run`` it::

    docker run -ti quay.io/my-user/test-repo

Create a custom image for my project
------------------------------------
We probably haven't included every Python module, every application and every
small utility that you need for your project. However, we have done all the
work of compiling and maintaing FEniCS. 

You can build off of our work by learning to write your own ``Dockerfile`` that
inherits ``FROM`` one of our pre-built images. We won't go into all of the
details of how to do this here, but can point you in the right direction. For
full details, take a look at the official Docker `tutorials
<https://docs.docker.com/engine/userguide/containers/dockerimages/>`_ and
`manual <https://docs.docker.com/engine/reference/builder/>`_ pages. 

Let's say that we need to run ``scipy`` alongside FEniCS in Python scripts
within a container. Because our image is built to be as lean as possible, we
don't include ``scipy`` by default. However, you can add it easily.

Begin by making an empty folder, for example ``my-docker-image/`` and create
a file called ``Dockerfile`` inside of it::

    mkdir my-docker-image
    cd my-docker-image
    touch Dockerfile

Then open up ``Dockerfile`` in your favourite text editor and add in 
the following text::

    FROM quay.io/fenicsproject/stable:latest
    USER root
    RUN apt-get -qq update && \
        apt-get -y upgrade && \
        apt-get -y install python-scipy && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
    USER root 

Let's go through each directive one-by-one. The ``FROM`` directive instructions
Docker to build the new image using ``quay.io/fenicsproject/stable:latest``
image as a base. The ``USER`` directive instructions Docker to run all
subsequent commands as the user ``root`` in the container. This method is
preferred to using ``sudo`` in the ``Dockerfile``. Then, we ``RUN`` a few shell
commands that update the ``apt-get`` cache and install ``scipy``. Note that we
clean up and delete the ``apt-get`` cache after using it. This reduces the
space requirements of the final image. Finally, we switch back to the ``USER``
``root``. The reasons for switching back to the user ``root`` are outside
the scope of this tutorial.

Save ``Dockerfile`` and exit back to the terminal, and then run::

    docker build .

Docker will ``build`` the container using the instructions in the
``Dockerfile``.  After the build is complete Docker will output a hash, e.g.::

     Successfully built 10c39a18651f

that you can ``tag`` your container for future use::

    docker tag 10c39 quay.io/my-user/my-docker-image
    
We can now ``run`` the container in the usual way::

    docker run -ti quay.io/my-user/my-docker-image

Now, inside the container, you should be able to use ``scipy`` and ``dolfin``::

    python -c "import scipy; import dolfin"

Congratulations, you've built your first Docker container!

This is just the beginning of what you can do to customise and build on our
containers. In general, if you can install it in Ubuntu, you can install it
in our container. For ideas, you can take a look at the source code of
our ``Dockerfiles`` `here <https://bitbucket.org/fenics-project/docker>`_ and
at the official Docker `tutorials
<https://docs.docker.com/engine/userguide/containers/dockerimages/>`_ and
`manual <https://docs.docker.com/engine/reference/builder/>`_ pages.

Use graphical applications on Linux hosts
-----------------------------------------
This allows X11 applications (e.g. matplotlib plot windows) to be displayed on
Linux host systems. To enable this, first run ``xhost +`` and then append ``-e
DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix`` to the Docker `run`
command. For example, you can run the stable version with::

    xhost +
    docker run -ti -e DISPLAY=$DISPLAY \
       -v /tmp/.X11-unix:/tmp/.X11-unix \
       quay.io/fenicsproject/stable

After exiting docker, execute ``xhost -`` on the host to restore X settings.
