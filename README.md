# Docker for FEniCS

## Introduction

We currently offer three images:

* `stable-ppa`: This image provides the most recent release of FEniCS
  and is recommended for most users. It contains the current stable
  FEniCS binaries from the official PPA.

      docker run -t -i fenicsproject/stable-ppa:latest

* `dev`: This image provides the development version of FEniCS.  It is
  for users looking for the latest features.

      docker run -t -i fenicsproject/dev:latest

* `dev-env`: This image provides a development environment in which a
   user can install FEniCS. It provides the necessary dependencies for
   FEniCS, but does not provide the FEniCS libraries. 

        docker run -t -i fenicsproject/dev-env:latest

  A helper script (fenics.conf) is provided in the container to compile 
  FEniCS. Just run:
  
      update_fenics

## Authors

* Jack Hale (<jack.hale@uni.lu>)
* Lizao Li (<lixx1445@umn.edu>)
* Garth N. Wells (<gnw20@cam.ac.uk>)
