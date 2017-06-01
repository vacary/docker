.. Documentation for using a container for FEniCS development

.. _developing:

FEniCS development using Docker
===============================

The FEniCS Docker images provide a convenient environment for FEniCS
development since the images provide all FEniCS dependencies.  Follow
the instructions below to create an environment that let's you pull,
push, edit and build FEniCS using Docker.


Development quickstart
----------------------

On the host:

.. code-block:: console

    curl -s https://get.fenicsproject.org | bash
    export FENICS_SRC_DIR=$HOME/dev/fenics
    mkdir -p $FENICS_SRC_DIR
    cd $FENICS_SRC_DIR
    for p in fiat instant dijitso ufl ffc dolfin mshr; do git clone git@bitbucket.org:fenics-project/$p.git; done
    fenicsproject pull dev-env
    fenicsproject create my-dev-env dev-env
    fenicsproject start my-dev-env

Inside the container:

.. code-block:: console

    fenics-build

The workflow is to edit the code and interact with the ``git``
repositories on the host with your favourite tools, and then build and
run FEniCS inside the container.

.. _start_of_full_instructions:


Install the ``fenicsproject`` script
------------------------------------

.. code-block:: console

    curl -s https://get.fenicsproject.org | bash

While it is possible to use straight ``docker`` commands to launch a
development container, the script makes things significantly easier.
Read on for full details: :ref:`start_of_full_instructions`.


Set up your FEniCS source tree
------------------------------

We will set up the FEniCS source tree on the host. This means you can
use all of your usual development tools, like ``vim`` or ``emacs`` `on
the host`, and just do the compilation and execution `inside the
container`. You should also use ``git push`` and ``git pull`` on the
host so that you can use your usual ``git`` SSH keys and setup.

We need to make a folder, e.g. ``$HOME/dev/fenics`` on the host system
to hold the FEniCS source code:

.. code-block:: console

    export FENICS_SRC_DIR=$HOME/dev/fenics
    mkdir -p $FENICS_SRC_DIR

You can make this setup permanent by setting the environment variable
``export FENICS_SRC_DIR=$HOME/dev/fenics`` in your ``$HOME/.profile``
or similar file. Feel free to choose another directory for your FEniCS
sources.


Pull the FEniCS sources
-----------------------

.. code-block:: console

    cd $FENICS_SRC_DIR
    git clone git@bitbucket.org:fenics-project/fiat.git
    git clone git@bitbucket.org:fenics-project/instant.git
    git clone git@bitbucket.org:fenics-project/dijitso.git
    git clone git@bitbucket.org:fenics-project/ufl.git
    git clone git@bitbucket.org:fenics-project/ffc.git
    git clone git@bitbucket.org:fenics-project/dolfin.git
    git clone git@bitbucket.org:fenics-project/mshr.git

Alternatively, the following short form can be used in place of the
string of clones:

.. code-block:: console

    for p in fiat instant dijitso ufl ffc dolfin mshr; do git clone git@bitbucket.org:fenics-project/$p.git; done

Note that we pull the sources from outside the Docker container (which
we have yet to create). This ensures that we pull using the ``ssh``
protocol (rather than the ``https`` protocol) and it ensures that you
can interact with the repositories using your normal credentials
(keys) on the host system. If you are using other repositories than
the standard ones (in particular forks not owned by
``fenics-project``), make suitable adjustments to the ``git clone``
commands above.


Create the Docker container
---------------------------

We will now setup the development container using the
``fenicsproject`` script.

.. code-block:: console

    fenicsproject pull dev-env
    cd $FENICS_SRC_DIR
    fenicsproject create my-dev-env dev-env

The first command pulls the latest FEniCS ``dev-env`` image containing
all the dependencies you need for building FEniCS such as PETSc and
MPI. This will happen automatically when you run the ``fenicsproject
create`` command below, but if you have previously used the
``dev-env`` image, make sure to run the ``fenicsproject pull`` command
to get the very latest version of the ``dev-env`` image.

The second command enters the FEniCS source directory. This is not
strictly necessary for our purposes, but the ``fenicsproject`` script
will complain if the ``fenicsproject create`` command is issued from
the home directory. Feel free to enter some other directory which will
then be shared to ``$HOME/shared`` inside the Docker container. The
source directory will automatically be shared anyway at
``$HOME/local/src``.

The third command creates a container named ``my-dev-env`` that you
will be using for FEniCS development. You may of course choose another
name for this container.


Start the FEniCS Docker container
---------------------------------

.. code-block:: console

    fenicsproject start my-dev-env

This command will fire up the Docker container and we are ready to get
going. The FEniCS source directory that we created previously will be
shared into the directory ``$HOME/local/src`` inside the container.


Build FEniCS inside the Docker container
----------------------------------------

To build all of the FEniCS components from the source you have shared
into the container, simply run the following command inside the
container:

.. code-block:: console

    fenics-build

If you want to develop with a Python 3 version of FEniCS instead type:

.. code-block:: console

    FENICS_PYTHON=python3 fenics-build

Both commands build all the sources residing in ``$HOME/local/src``
and install the results into ``$HOME/local``. Once all components have
been built, you may run FEniCS programs without changing any paths or
setting any other environment variables. Everything is already setup
correctly to point at the ``$HOME/local`` installation directory.

Note that there is also a command named ``fenics-pull``. This will
pull all the FEniCS sources into ``$HOME/local/src`` by entering each
source directory and calling ``git pull``. This means that the command
will pull the sources for the default remote for the particular branch
that each repository happens to be located at.

During development, you will likely need to rebuild and install a
particular component repeatedly. For example, to re-build ffc:

.. code-block:: console

    fenics-build ffc
