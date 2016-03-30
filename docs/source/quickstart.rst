.. Simple quick start that should be synced with the web page
   instructions

Quickstart
==========

To get started, follow these three steps:

#. Install Docker. Mac and Windows users should install the `Docker
   Toolbox <https://www.docker.com/products/docker-toolbox>`_ (this is
   a simple one-click install) and Linux users should `follow these
   instructions <https://docs.docker.com/linux/step_one/>`_.
#. If running on Mac or Windows, make sure you have the Docker
   Quickstart Terminal running. (This may take a little while the
   first time so just be patient.)
#. Run the prebuilt FEniCS image using the following command::

    docker run -ti quay.io/fenicsproject/stable

*Didn't work?* Try the :ref:`troubleshooting` section.

The first time you run this command, Docker will automatically fetch
the image for the latest stable version of FEniCS. For the latest
development version of FEniCS, just change ``stable`` to ``dev``.

To share files between your operating system and the FEniCS Docker
image, add the ``-v`` flag to tell Docker where your files are, for
example::
    
    docker run -ti -v $(pwd):/home/fenics/shared quay.io/fenicsproject/stable

Files in the directory ``$(pwd)`` will be shared into the container at
``/home/fenics/shared``. Updates to files in the container will be reflected on
the host, and vice versa. We recommend keeping all of your source code and
generated results in this shared directory. Then you can use all of your
favourite text editors and command line tools on the host as usual.

Finally, we also recommend giving every Docker container a name so you can
refer to it easily in the future. ``fenics`` might be a good name for your
first container, or perhaps the name of the project you are working on::

    docker run -ti -v $(pwd):/home/fenics/shared --name fenics quay.io/fenicsproject/stable

Then, if you `exit` the container, you can always start it again and
get another bash session using the commands::

    docker start fenics
    docker exec -ti fenics /bin/bash -l

If you want to see information on every container you have ever started, just
type on the host::

    docker ps -a

You should see the container ``fenics`` that we created in the previous
steps.

The above instructions will get you quickly up and running with FEniCS in
Docker. We recommend continuing to the :ref:`introduction` for more details on
:ref:`sharing_introduction` and :ref:`naming_introduction`.
