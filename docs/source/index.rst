.. FEniCS Containers documentation master file, created by
   sphinx-quickstart on Sun Mar 13 10:22:20 2016.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

=============================
FEniCS in Containers - Docker
=============================

This is the documentation for Linux/Docker containers for the FEniCS
libraries from the FEniCS Project (http://fenicsproject.org).
Containers provide a consistent and portable FEniCS environment, for
both running FEniCS applications and developing FEniCS. On modern
Linux systems there is no performance penalty when running in a
container compared to running natively on the host system. In many
cases, the container versions of FEniCS are faster than user
installations as the containers have been tuned for performance by the
FEniCS developers. On non-Linux based systems, the containers will run
inside a virtual machine.

The Docker images are automatically built on quay.io at
https://quay.io/repository/fenicsproject/. The Dockerfiles for the
containers are maintained at
https://bitbucket.org/fenics-project/docker. Images are provided of
both release and development versions of FEniCS.


.. toctree::
   :caption: Table of Contents
   :maxdepth: 2


Getting started
===============


What is Docker?
---------------


Installing Docker
-----------------

Instructions for installing Docker are available at:

- Linux: https://docs.docker.com/linux/ and
  https://docs.docker.com/engine/installation/
- OSX: https://docs.docker.com/mac/
- Windows: https://docs.docker.com/windows/



Running an image for the first time
-----------------------------------


Sharing files from the host into the container
----------------------------------------------


Images
======

We currently offer seven end-user images.

Summary
-------

.. |stable| image:: https://quay.io/repository/fenicsproject/stable/status
.. |dolfin-adjoint| image:: https://quay.io/repository/fenicsproject/dolfin-adjoint/status
.. |dev| image:: https://quay.io/repository/fenicsproject/dev/status
.. |dev-env| image:: https://quay.io/repository/fenicsproject/dev-env/status
.. |dev-env-dbg| image:: https://quay.io/repository/fenicsproject/dev-env-dbg/status
.. |dev-env-trilinos| image:: https://quay.io/repository/fenicsproject/dev-env-trilinos/status
.. |dev-env-py3| image:: https://quay.io/repository/fenicsproject/dev-env-py3/status
.. |base| image:: https://quay.io/repository/fenicsproject/base/status
.. |dev-env-base| image:: https://quay.io/repository/fenicsproject/dev-env-base/status

+------------------+---------------------+-----------------------------------------------+
| **Image name**   | **Build status**    | **Short Description**                         |
+------------------+---------------------+-----------------------------------------------+
| stable           | |stable|            | Stable release, with PETSc and SLEPc.         |
+------------------+---------------------+-----------------------------------------------+
| dolfin-adjoint   | |dolfin-adjoint|    | As `stable`, but with dolfin-adjoint.         |
+------------------+---------------------+-----------------------------------------------+
| dev              | |dev|               | Development version.                          |
+------------------+---------------------+-----------------------------------------------+
| dev-env          | |dev-env|           | Development environment with PETSc and SLEPc. |
+------------------+---------------------+-----------------------------------------------+
| dev-env-dbg      | |dev-env-dbg|       | As `dev-env`, but with debugging symbols.     |
+------------------+---------------------+-----------------------------------------------+
| dev-env-trilinos | |dev-env-trilinos|  | As `dev-env`, but with Trilinos.              |
+------------------+---------------------+-----------------------------------------------+
| dev-env-py3      | |dev-env-py3|       | As `dev-env`, but with Python 3.              |
+------------------+---------------------+-----------------------------------------------+
| dev-py3          | No automatic build. | As `dev`, but with Python 3.                  |
+------------------+---------------------+-----------------------------------------------+
| base             | |base|              | Base image, not for end users.                |
+------------------+---------------------+-----------------------------------------------+
| dev-env-base     | |dev-env-base|      | Base image, not for end users.                |
+------------------+---------------------+-----------------------------------------------+


Detailed descriptions
---------------------

FEniCS library images
^^^^^^^^^^^^^^^^^^^^^

* stable: This image provides the most recent release of FEniCS and is
  recommended for most users. It has most recent versions of PETSc,
  SLEPc, petsc4py and slepc4py that are compatible with the most
  recent FEniCS release.

* dev: This image provides a snapshot of the development version of
  FEniCS.


FEniCS development environments
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

* dev-env: This image provides a snapshot of the development version
  of FEniCS.



I want to...
=============


Have a separate container for each project
------------------------------------------


Have multiple shells running in one container
---------------------------------------------


Reproduce my results
--------------------


Share my container with a colleague
-----------------------------------


Contribute to the FEniCS Project
--------------------------------


Create a custom image for my team
---------------------------------


Run FEniCS in the cloud
-----------------------


Contact
=======

Support requests can be sent to the FEniCS Support mailing list
(fenics-support@googlegroups.com).

For development-related questions and suggestions, use the FEniCS
Development mailing list (fenics-dev@googlegroups.com). Bugs can be
registered on the Bitbucket Issue Tracker
(https://bitbucket.org/fenics-project/docker/issues).



Indices and tables
==================

* :ref:`genindex`
* :ref:`search`
