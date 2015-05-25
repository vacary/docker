# Docker for FEniCS

## Introduction

We currently offer three images:

* `stable-ppa`: This image provides the more recent release of FEniCS
  and is recommended for most users. It contains the current stable
  FEniCS binaries from official PPA.
* `dev`: This image provides the development version of FEniCS.  It is
  for users looking for the latest features.
* `dev-env`: This image provides a development environment in which a
   user can install FEniCS. It provides the necessary dependencies for
   FEniCS, but does not provide the FEniCS libraries.

`stable` is the default choice. To choose other version, edit the
beginning of the script `fenics` and change `VERSION=stable`.

To use FEniCS, simply execute `./fenics`. To run with X11 forwarding,
pass the "-gui" option.


## Persistent mode

By default the container is destroyed after each run so only the
changes to the shared directory is saved. This is sufficient for many
use cases. Sometimes, however, it might be advantageous to have a
persistent container, for example, when some additional packages are
installed inside. In the persistent mode, modifications to the system
inside the container are also saved. To use this, edit the beginning
of script `fenics` and modify `PERSISTENT=false` accordingly. In this
case, the user has to destroy the container by hand when it is not
needed any more. To do this, run (change `stable` to the version you
use):

    docker rm fenics-docker-stable

There is a trade-off. When FEniCS upgrades, for example, the user has
to migrate all the changes to the old container to the new version by
hand. Therefore it is recommended that persistent mode users keep a
list of changes (additional packages installed and so on).

One alternative to this is to build another customized docker image
based on the official ones offered here. This has its own trade-offs
and requires more knowledge of docker.


## Authors

* Jack Hale (<jack.hale@uni.lu>)
* Lizao Li (<lixx1445@umn.edu>)
* Garth N. Wells (<gnw20@cam.ac.uk>)
