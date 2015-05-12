Docker for FEniCS
=================

Introduction
============

We currently offer 3 versions:

* `stable`: This is recommended for most users. It contains the current
  stable FEniCS binaries from official PPA. The download size is 2.4G.
* `git`: This is for users looking for bleeding edge features. It
  contains the FEniCS binaries built from git source on a weekly basis. The
  download size is 2.6G for the first time and 1.0G for subsequent updates.
* `dev`: This is for developers of FEniCS or users who want to study or
  modify the source code of FEniCS. This can also serve as a way to get the
  git version with a smaller download size. It contains all the
  dependencies and a script to build FEniCS. The download size is 1.7G.

`stable` is the default choice. To choose other version, edit the beginning
of the script `fenics` and change `VERSION=stable`.

To use fenics, simply execute `./fenics`. The GUI is enabled by default. To
run CLI-only, pass the "-c" option.

Persistent mode
===============

By default the container is destroyed after each run so only the changes to
the shared directory is saved. This is sufficient for many use
cases. Sometimes, however, it might be advantageous to have a persistent
container, for example, when some additional packages are installed
inside. In the persistent mode, modifications to the system inside the
container are also saved. To use this, edit the beginning of script
`fenics` and modify `PERSISTENT=false` accordingly. In this case, the user
has to destroy the container by hand when it is not needed any more. To do
this, run (change `stable` to the version you use):

    docker rm fenics-docker-stable

There is a trade-off. When FEniCS upgrades, for example, the user has to
migrate all the changes to the old container to the new version by
hand. Therefore it is recommended that persistent mode users keep a list of
changes (additional packages installed and so on).

One alternative to this is to build another customized docker image based
on the official ones offered here. This has its own trade-offs and requires
more knowledge of docker.
