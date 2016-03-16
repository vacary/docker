.. FEniCS Containers documentation master file, created by
   sphinx-quickstart on Sun Mar 13 10:22:20 2016.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

=============================
FEniCS in Containers - Docker
=============================

This is the documentation for Linux/Docker containers for the FEniCS
libraries from the FEniCS Project (http://fenicsproject.org).

The Dockerfiles for the containers are maintained at
https://bitbucket.org/fenics-project/docker.

Built version of the containers are hosted on quay.io at
https://quay.io/repository/fenicsproj0ect/.


Contents
========

.. toctree::
   :maxdepth: 2


Getting started
===============


What is Docker?
---------------


Installing Docker
-----------------


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


Full descriptions
-----------------

* stable: This image provides the most recent release of FEniCS and is
  recommended for users who need the latest versions of PETSc, SLEPc, petsc4py
  and slepc4py.

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

Indices and tables
==================

* :ref:`genindex`
* :ref:`search`
