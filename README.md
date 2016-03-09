# Docker for FEniCS

This repository contains the scripts for building various Docker
images for FEniCS (<http://fenicsproject.org>).


## Introduction

To install Docker for your platform (Windows, Mac OS X, Linux, cloud platforms,
etc.), follow the instructions at
(<https://docs.docker.com/engine/installation/>).

We currently offer nine images. Most end-users are probably looking
for the `stable`, `stable-ppa` or `dolfin-adjoint` images:

* `stable`: This image provides the most recent release of FEniCS and
  is recommended for users who need the latest versions of PETSc,
  SLEPc, petsc4py and slepc4py.

      docker run -t -i fenicsproject/stable:latest

* `stable-ppa`: This image provides the most recent release of FEniCS
  and is recommended for most users. It contains the current stable
  FEniCS binaries from the official PPA.

      docker run -t -i fenicsproject/stable-ppa:latest

* `dolfin-adjoint`: Identical to `stable`, but also includes dolfin-adjoint. 

      docker run -t -i fenicsproject/dolfin-adjoint:latest

Developers and more advanced users may be interested in the following
images:

* `dev`: This image provides the development version of FEniCS.  It is
  for users looking for the latest features.

      docker run -t -i fenicsproject/dev:latest

* `dev-env`: This image provides a development environment in which a
   user can compile FEniCS. It provides the necessary dependencies for
   FEniCS, but does not provide the FEniCS libraries. Debugging symbols
   are disabled in PETSc and SLEPc.

      docker run -t -i fenicsproject/dev-env:latest

   A helper script (fenics.conf) is provided in the container to the compile
   FEniCS. Just run:

      update_fenics

* `dev-env-dbg`: Identical to `dev-env`, except that PETSc and SLEPc are
   compiled with debugging symbols. 

      docker run -t -i fenicsproject/dev-env-dbg:latest

* `dev-env-tpetra`: Identical to `dev-env`, except that Trilinos is also
  compiled.

      docker run -t -i fenicsproject/dev-env-tpetra:latest

* `dev-py3`: Identical to `dev`, except with a Python 3 version of DOLFIN
  installed.

      docker run -t -i fenicsproject/dev-py3:latest

* `dev-env-py3`: Identical to `dev-env`, except with Python 3.

      docker run -t -i fenicsproject/dev-env-py3:latest

## Issues

* Docker images default to using the Google Domain Name Servers
  (DNS). Access to these may be blocked on some networks. In this
  case, you can set the address of the DNS using the Docker option
  `--dns`, e.g.:

        docker run --dns=4.4.4.4 -t -i fenicsproject/dev-env:latest

  and replace `4.4.4.4` with the address of your local DNS.

  For setting the DNS system-wide, see
  <https://docs.docker.com/engine/admin/systemd/> and
  <https://stackoverflow.com/questions/33784295/setting-dns-for-docker-daemon-using-systemd-drop-in/>.


## Building images

Images are hosted on Docker Hub, and are automatically built on Docker
Hub from the Dockerfiles in this repository. The FEniCS Docker Hub
page is at <https://hub.docker.com/r/fenicsproject/>.


### Developer notes

The images on Dockerhub are built automatically upon pushes to this
repository. The images tagged `latest` (the stable images) are built
from the Dockerfiles in the branch `build`. The images tagged
`experimental` are built from Dockerfiles in the branch `master`.
When a Dockerfile is ready to move from `experimental` to `latest`,
merge `master` into `build`.


## Authors

* Jack Hale (<jack.hale@uni.lu>)
* Lizao Li (<lixx1445@umn.edu>)
* Garth N. Wells (<gnw20@cam.ac.uk>)
