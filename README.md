# Docker for FEniCS

This repository contains the scripts for building various Docker
images for FEniCS (http://fenicsproject.org).

[![Documentation Status](https://readthedocs.org/projects/fenics-containers/badge/?version=latest)](http://fenics.readthedocs.org/projects/containers/en/latest/?badge=latest)

## Introduction

To install Docker for your platform (Windows, macOS, Linux, cloud
platforms, etc.), follow the instructions at
https://docs.docker.com/engine/getstarted/step_one/.

Once you have Docker installed, you can run any of the images below
using the following command:

    docker run -ti quay.io/fenicsproject/<image-name>:latest

To start with you probably want to try the `stable:current` image
which includes a full stable version of FEniCS with PETSc, SLEPc,
petsc4py and slepc4py already compiled. This image has been checked by
the FEniCS Project team:

    docker run -ti quay.io/fenicsproject/stable:current

If you want to share your current working directory into the container
use the following command:

    docker run -ti -v $(pwd):/home/fenics/shared quay.io/fenicsproject/<image-name>:latest

Users with SELinux-enabled Linux distributions (Redhat, Fedora, CentOS, and others)
will need to add the `:z` flag to the volume mount, e.g.:

    docker run -ti -v $(pwd):/home/fenics/shared:z quay.io/fenicsproject/<image-name>:latest

## Documentation

More extensive documentation, including suggested workflows, is
available at https://fenics-containers.readthedocs.org/.


## Images

We currently offer following end-user images. A full description of
the images can be found at https://fenics-containers.readthedocs.org/.

> Looking for images with dolfin-adjoint already installed? Check out
> https://bitbucket.org/dolfin-adjoint/virtual.

| Image name       | Build status                                                                                                                                                                            | Description                                   |
|------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|
| stable           | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/stable/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/stable)                           | Stable release, with PETSc and SLEPc.         |
| dev-env          | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev-env/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev-env)                   | Development environment with PETSc and SLEPc. |
| dev-env-dbg      | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev-env-dbg/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev-env-dbg)           | As `dev-env`, but with debugging symbols.     |
| dev-env-trilinos | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev-env-trilinos/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev-env-trilinos) | As `dev-env`, but with Trilinos.              |
| base             | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/base/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/base)                         | Base image, not for end users.                |
| dev-env-base     | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev-env-base/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev-env-base)         | Base image, not for end users.                |

> Note: The *Build status* column refers to the latest *attempted*
> build. Even if a build is marked as failed, there will still be a
> working image available on the `latest` tag that you can use.

## Tags

We only maintain tags on the `quay.io/fenicsproject/stable` image:

https://quay.io/repository/fenicsproject/stable?tab=tags

The current policy for producing these tags is as follows:

* The `:latest` (default) tag refers to the latest image built by
quay.io.
* We maintain a permanent set of rolling release tags, e.g.
`:2016.1.0.r1`, `2016.1.0.r2` that contain the `xxxx.x.x` version of
FEniCS, but contain minor updates `.rx` to underlying dependencies
(e.g. PETSc) and the container environment. These images have been
checked thoroughly by the FEniCS project team.
* The latest rolling release is tagged with a *moving* tag `:current`.
This tag is the default tag used by the `bin/fenicsproject` script
when the user specifies `stable`.
* When we release a new version of FEniCS the last rolling release of
the image for the previous version will be tagged `xxxx.x.x` for
permanent archival. We will endeavour to keep all `xxxx.x.x.rx` tags
as well, but this is not guaranteed.

## Building images

Images are hosted on quay.io, and are automatically built in the cloud
on from the Dockerfiles in this repository. The FEniCS Project quay.io
page is at https://quay.io/organization/fenicsproject/.

## Authors

* Jack S. Hale (<jack.hale@uni.lu>)
* Lizao Li (<lzlarryli@gmail.com>)
* Garth N. Wells (<gnw20@cam.ac.uk>)
