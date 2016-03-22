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

*Didn't work?* Try the :ref:`troubleshooting` section.

The first time you run this command, Docker will automatically fetch
the image for the latest stable version of FEniCS. For the latest
development version of FEniCS, just change ``stable`` to ``dev``.

To share files between your operating system and the FEniCS Docker
image, add the ``-v`` flag to tell Docker where your files are, for
example::

    docker run -ti -v $(pwd):/home/fenics/shared quay.io/fenicsproject/stable

Any files you place in the directory ``/home/fenics/shared`` in the container
will be available on the host system at ``$(pwd)``, and vice versa. We
recommend keeping the source code and generated results for your projects in
this shared directory, easily accessible on the host machine.

Any files placed in *any* other directory than ``/home/fenics/shared`` in the
container will *remain* in the container and are not accessible on the host.

For this reason, we recommend giving *every* container you make a ``--name`` so
that you can easily restart it and access the data within it at a later date::

    docker run -ti -v $(pwd):/home/fenics/shared --name myproject quay.io/fenicsproject/stable

If you type ``exit`` in the container, you can restart and get a fresh shell
with the commands::

    docker start myproject
    docker exec -ti myproject /bin/bash -l

For more detailed instructions, check out :ref:`seperate-container` and
:ref:`exited-container`.

The above instructions will get you quickly up and running with FEniCS
in Docker. Read on for details on more advanced features.
