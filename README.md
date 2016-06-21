# Docker for FEniCS

This repository contains the scripts for building various Docker
images for FEniCS (<http://fenicsproject.org>).

[![Documentation Status](https://readthedocs.org/projects/fenics-containers/badge/?version=latest)](http://fenics.readthedocs.org/projects/containers/en/latest/?badge=latest)

## Introduction

To install Docker for your platform (Windows, macOS, Linux, cloud platforms,
etc.), follow the instructions at
(<https://docs.docker.com/engine/getstarted/step_one/>).

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
construction at <https://fenics-containers.readthedocs.org/>.


## Images

We currently offer following end-user images. A full description of the images can be found at
<https://fenics-containers.readthedocs.org/>.

> Looking for images with dolfin-adjoint already installed? Check out <https://bitbucket.org/dolfin-adjoint/virtual>.

| Image name       | Build status                                                                                                                                                                            | Description                                   |
|------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|
| stable           | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/stable/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/stable)                           | Stable release, with PETSc and SLEPc.         |
| dev              | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev)     | Development version.                          |
| dev-env          | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev-env/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev-env)                   | Development environment with PETSc and SLEPc. |
| dev-env-dbg      | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev-env-dbg/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev-env-dbg)           | As `dev-env`, but with debugging symbols.     |
| dev-env-trilinos | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev-env-trilinos/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev-env-trilinos) | As `dev-env`, but with Trilinos.              |
| dev-env-py3      | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev-env-py3/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev-env-py3)           | As `dev-env`, but with Python 3.              |
| dev-py3          | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev-py3/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev-py3)                   | As `dev`, but with Python 3.                                                                                                                                                 | As `dev`, but with Python 3.                  |
| base             | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/base/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/base)                         | Base image, not for end users.                |
| dev-env-base     | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev-env-base/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev-env-base)         | Base image, not for end users.                |

> Note: The *Build status* column refers to the latest *attempted* build. Even
> if a build is marked as failed, there will still be a working image available
> on the `latest` tag that you can use.

## Building images

Images are hosted on quay.io, and are automatically built in the cloud on from
the Dockerfiles in this repository. The FEniCS Project quay.io page is at
<https://quay.io/organization/fenicsproject/>.

## Authors

* Jack S. Hale (<jack.hale@uni.lu>)
* Lizao Li (<lzlarryli@gmail.com>)
* Garth N. Wells (<gnw20@cam.ac.uk>)
