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
#. Run the prebuilt FEniCS image by the following command::

    docker run -ti quay.io/fenicsproject/stable

The first time you run this command, Docker will automatically fetch
the image for the latest stable version of FEniCS. For the latest
development version of FEniCS, just change ``stable`` to ``dev``.

To share files between your operating system and the FEniCS Docker
image, add the ``-v`` flag to tell Docker where your files are, for
example::

    docker run -ti -v $(pwd):/home/fenics/shared quay.io/fenicsproject/stable

The above instructions will get you quickly up and running with FEniCS
in Docker. Read on for details on more advanced features.
