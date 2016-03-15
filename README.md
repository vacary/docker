# Docker for FEniCS

This repository contains the scripts for building various Docker
images for FEniCS (<http://fenicsproject.org>).


## Introduction

To install Docker for your platform (Windows, Mac OS X, Linux, cloud platforms,
etc.), follow the instructions at
(<https://docs.docker.com/engine/installation/>).

Once you have Docker installed, you can run any of the images below using the
following command:

        docker run -ti quay.io/fenicsproject/<image-name>:latest
        
To start with you probably want to try the `stable` image which includes a full
stable version of FEniCS with PETSc, SLEPc, petsc4py and slepc4py already
compiled.

If you want to share your current working directory into the container use
the following command:

        docker run -ti -v $(pwd):/home/fenics/shared quay.io/fenicsproject/<image-name>:latest

## Documentation

More extensive documentation, including suggested workflows is currently under
construction at (<https://fenics-containers.readthedocs.org/>).

## The images

We currently offer seven end-user images. A full description of the images can be found at (<https://fenics-containers.readthedocs.org/>).

| Image name       | Build status                                                                                                                                                                                    |
|------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| stable           | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev)                                   |
| dolfin-adjoint   | [Docker Repository on Quay](https://quay.io/repository/fenicsproject/dolfin-adjoint/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dolfin-adjoint)               |
| dev              | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dolfin-adjoint/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dolfin-adjoint)             |
| dev-env          | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev-env/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev-env)                           |
| dev-env-dbg      | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev-env-dbg/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev-env-dbg)                   |
| dev-env-trilinos | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev-env-trilinos/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev-env-trilinos)         |
| dev-env-py3      | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev-env-py3/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev-env-py3)                   |
| dev-py3          | No automatic build.                                                                                                                                                                             |
| base             | `base`: [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/base/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/base)                         |
| dev-env-base     | `dev-env-base`: [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev-env-base/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev-env-base) |

### Application images

Most end-users are probably looking for the `stable` or `dolfin-adjoint` images:

* `stable`: This image provides the most recent release of FEniCS and
  is recommended for users who need the latest versions of PETSc,
  SLEPc, petsc4py and slepc4py.
  [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev)

* `dolfin-adjoint`: Identical to `stable`, but also includes dolfin-adjoint.
  [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dolfin-adjoint/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dolfin-adjoint) 

### Development and advanced images

Developers and more advanced users may be interested in the following
images:

* `dev`: This image provides the development version of FEniCS.  It is
  for users looking for the latest features.
  [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dolfin-adjoint/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dolfin-adjoint)

* `dev-env`: This image provides a development environment in which a
   user can compile FEniCS easily. It provides the necessary dependencies for
   FEniCS, but does not provide the FEniCS libraries. Debugging symbols
   are disabled in PETSc and SLEPc.
   [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev-env/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev-env)

* `dev-env-dbg`: Identical to `dev-env`, except that PETSc and SLEPc are
  compiled with debugging symbols. 
  [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev-env-dbg/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev-env-dbg) 

* `dev-env-trilinos`: Identical to `dev-env`, except that Trilinos is also
  compiled.
  [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev-env-trilinos/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev-env-trilinos)

* `dev-env-py3`: Identical to `dev-env`, except with Python 3.
  [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev-env-py3/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev-env-py3)

### Images that you can build yourself

The following images are deprecated and can be built using the 
command `docker build .` in the directory of the Dockerfile 
on your own computer.

* `stable-ppa`: *Removed and deprecated*, use image `stable` instead.

* `dev-py3`: Identical to `dev`, except with a Python 3 version of DOLFIN
  installed. Because FEniCS is not yet fully compatible with Python 3
  we are not building the Python 3 version at the moment on <https://quay.io>.

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

Images are hosted on quay.io, and are automatically built in the cloud on from
the Dockerfiles in this repository. The FEniCS Project quay.io page is at
<https://quay.io/organization/fenicsproject/>.

### Developer notes

The images on Dockerhub are built automatically upon pushes to this
repository. The images tagged `latest` (the stable images) are built
from the Dockerfiles in the branch `build`. The images tagged
`experimental` are built from Dockerfiles in the branch `master`.
When a Dockerfile is ready to move from `experimental` to `latest`,
merge `master` into `build`.

The image `base` defines the end-user experience for all containers, including
creating the `fenics` user, setting default `ENTRYPOINT` and `CMD` variables,
and setting the version of `phusion/baseimage` to use. All other images should
ultimately inherit `FROM` this image.

`base`: [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/base/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/base)

The image `dev-env-base` includes the `fenics.conf` helper script, the
`fenics.env.conf` environment variable script, and sets the version numbers of
the packages to compile in the child images. All `dev-env-{variant}` should
inherit `FROM` this image.

`dev-env-base`: [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev-env-base/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev-env-base)

## Authors

* Jack S. Hale (<jack.hale@uni.lu>)
* Lizao Li (<lixx1445@umn.edu>)
* Garth N. Wells (<gnw20@cam.ac.uk>)
