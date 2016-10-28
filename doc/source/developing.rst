.. Documentation for using a container for FEniCS development

.. _developing:

FEniCS development using Docker
===============================

The FEniCS Docker images provide a convenient environment for FEniCS
development since the images provide all FEniCS dependencies.  Follow
the instructions below to create an environment that let's you pull,
push, edit and build FEniCS using Docker.

Install the ``fenicsproject`` script
------------------------------------

.. code-block:: console

    curl -s https://get.fenicsproject.org | bash

This step can be skipped if you prefer to work through native Docker
commands.

Set up your FEniCS source tree
------------------------------

.. code-block:: console

    export FENICS_SRC_DIR=$HOME/fenics/dev
    mkdir -p $FENICS_SRC_DIR

Make sure to set the environment variable ``FENICS_SRC_DIR`` in your
``$HOME/.bash_aliases`` (Linux) or ``$HOME/.profile`` (Mac) or similar
file. And feel free to choose another directory for your FEniCS
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
the standard ones (in particular forks not owned by ``fenics-project``),
make suitable adjustments to the clone commands above.

Create the Docker container
---------------------------

.. code-block:: console

    fenicsproject pull dev-env
    cd $FENICS_SRC_DIR
    fenicsproject create dev dev-env

The first command pulls the latest FEniCS ``dev-env`` image containing
all the dependencies you need for building FEniCS such as PETSc, MPI
etc. This will happen automatically when you run the ``fenicsproject
create`` command below, but if you have previously used the ``dev-env``
image, make sure to run the ``fenicsproject pull`` command to get a
fresh version of the ``dev-env`` image.

The second command enters the FEniCS source directory. This is
strictly not necessary for our purposes, but the ``fenicsproject``
script will complain if the ``fenicsproject create`` command is issued
from the home directory. Feel free to enter some other directory which
will then be shared to ``$HOME/shared`` inside the Docker
container. The source directory will automatically be shared anyway.

The third command creates a container named ``dev`` that you will be
using for FEniCS development. You may of course choose another name
for this container.

Start the FEniCS Docker container
---------------------------------

.. code-block:: console

    fenicsproject start dev

This command will fire up the Docker container and we are ready to get
going. The FEniCS source directory that we created previously will be
shared into the directory ``$HOME/local/src`` inside the container.

Build FEniCS inside the Docker container
----------------------------------------

.. code-block:: console

    fenics-build

Run this command inside the Docker container to build all the sources
residing in ``$HOME/local/src`` and install into ``$HOME/local``. Once
all components have been built, you may run FEniCS programs without
changing any paths or setting any other environment variables. These
are already pointed to the ``$HOME/local`` installation directory.

Note that there is also a command named ``fenics-pull``. This will
pull all the FEniCS sources into ``$HOME/local/src`` by entering each
source directory and calling ``git pull``. This means that the command
will pull the sources for the default remote for the particular branch
that each repository happens to be located at.

During development, you will likely need to rebuild and install a
particular component repeatedly. For a Python component, such as FFC,
this means entering the source directory and running the following
command:

.. code-block:: console

    pip install --prefix=${FENICS_PREFIX} .

.. note:: Do we need the full line: ``pip install --prefix=${FENICS_PREFIX} --no-deps --upgrade .``?

For DOLFIN and mshr, enter the build directory and run ``make``, for
example:

.. code-block:: console

    cd $FENICS_SRC_DIR/dolfin
    cd build
    make
    make install

.. note:: Consider adding a command ``fenics-build-component`` that takes care of this step and autodetects whether it's a Python or C++ project. This command may then be called from ``fenics-build``.

Editing source files, pulling and pushing changes
-------------------------------------------------

If you have followed the above instructions, you can interact with the
source repositories using regular Git commands and edit the sources
using your favorite editor (Emacs). Just make sure to interact with
the repositories and edit the files on your `host system`; that is,
don't try to push and pull from inside the Docker container. In other
words, edit the files on your host system and build/run inside the
container. This is easily done by keeping a terminal open with the
``dev`` container running for building, testing and running the code.
