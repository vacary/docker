# Docker for FEniCS

This repository contains the scripts for building various Docker
images for [FEniCS](http://fenicsproject.org). The built images
are available on [quay.io](https://quay.io/organization/fenicsproject/).

[![Documentation Status](https://readthedocs.org/projects/fenics-containers/badge/?version=latest)](http://fenics.readthedocs.org/projects/containers/en/latest/?badge=latest)

## Introduction

To install Docker for your platform (Windows, macOS, Linux, cloud
platforms, etc.), follow the instructions at
[docker.com](https://docs.docker.com/engine/getstarted/step_one/).

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
> [this page](https://bitbucket.org/dolfin-adjoint/dolfin-adjoint/src/master/docker/?at=master).

| Image name       | Build status                                                                                                                                                                            | Description                                   |
|------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|
| stable           | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/stable/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/stable)                     | Stable release, with PETSc and SLEPc.         |
| dev              | [![Build Status on Bamboo](http://fenics-bamboo.simula.no:8085/plugins/servlet/wittified/build-status/FENICS-FDI)](https://quay.io/repository/fenicsproject/dev)                           | `master` version, produced by [Bamboo](https://bamboo.fenicsproject.org). |
| dev-env          | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev-env/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev-env)                   | Development environment with PETSc and SLEPc. |
| dev-env-trilinos | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/dev-env-trilinos/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/dev-env-trilinos) | As `dev-env`, but with Trilinos.              |
| base             | [![Docker Repository on Quay](https://quay.io/repository/fenicsproject/base/status "Docker Repository on Quay")](https://quay.io/repository/fenicsproject/base)                         | Base image, not for end users.                |

> Note: The *Build status* column refers to the latest *attempted*
> build. Even if a build is marked as failed, there will still be a
> working image available on the `latest` tag that you can use.

## Tagging policies

### `stable`

We currently maintain tags on the `stable` and `dev-env` images.

You can view the tags on the `stable` image here:

https://quay.io/repository/fenicsproject/stable?tab=tags

The tagging policy for `stable` image is as follows:

* The `:latest` (default) tag refers to the latest image built by
quay.io. The prior `:latest` image is automatically deleted by
quay.io, unless it has been assigned another tag.
* We maintain a permanent set of rolling release tags, e.g.
`:2016.1.0.r1`, `2016.1.0.r2` that contain the `xxxx.x.x` version of
FEniCS, but contain minor updates `.rx` to underlying dependencies
(e.g. PETSc) and the container environment. These images have been
checked thoroughly by the FEniCS project team.
* The latest rolling release is tagged with a *moving* tag `:current`.
This tag is the default tag used by the `bin/fenicsproject` script
when the user specifies `stable`.
* When we release a new stable version of FEniCS the last rolling release
`xxxx.x.x.rx` of the image for the previous version will be tagged `xxxx.x.x` for
permanent archival. We will endeavour to keep all `xxxx.x.x.rx` tags
as well, but this is not guaranteed.

### `dev-env`

You can view the tags on the `dev-env` image here:

https://quay.io/repository/fenicsproject/stable?tab=tags

The tagging policy for the `dev-env` image is as follows:

* The `:latest` (default) tag refers to the latest image build by
quay.io. The prior `:latest` image is automatically deleted by
quay.io, unless it has been assigned another tag.
* When we release a new stable version of FEniCS the last `:latest` image is
tagged `xxxx.x.x` for permanent archival. This could be useful if you
want to compile an old version of FEniCS.

## Development images

We also provide a set of *unsupported* images containing the output of
all builds produced during our continuous integration and testing
[system](https://bamboo.fenicsproject.org):

[https://quay.io/organization/fenicsproject_dev](https://quay.io/organization/fenicsproject_dev)

These images are not guaranteed to work and we do not provide end-user
support. They may be of use to developers and contributors for
debugging issues in pull requests or trying out bleeding edge features.

Development images are automatically deleted after a set period of
time. Pushing a new commit to a branch will re-build the image.

## Process

The `Dockerfile`s in this repository are built and distributed as
Docker images by quay.io. For this to happen automatically on a change
in a `Dockerfile` we have setup a [build
trigger](https://docs.quay.io/guides/building.html) on quay.io for
each image (e.g. `stable`). Setting up a trigger requires
administrator access on this bitbucket repository and the
`fenicsproject` quay.io team.

The tagging policy is described in the section 'Tagging policies'.  To
create tags you need to be an administrator on the `fenicsproject`
quay.io team. The procedure is described
[here](https://docs.quay.io/guides/tag-operations.html). Currently all
tags are created manually via the web interface.

## Authors

* Jack S. Hale (<jack.hale@uni.lu>)
* Lizao Li (<lzlarryli@gmail.com>)
* Garth N. Wells (<gnw20@cam.ac.uk>)
