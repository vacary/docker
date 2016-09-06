.. Description of the FEniCS Docker images

List of FEniCS Docker images
============================

We currently offer the following end-user images. The ``stable`` image is
recommended for most users, but advanced users or developers may want to use
other images.

The images are automatically built on quay.io at
https://quay.io/repository/fenicsproject/. The Dockerfiles for the
containers are maintained on `Bitbucket
<https://bitbucket.org/fenics-project/docker>`_.

Summary of available images
---------------------------

.. |stable| image:: https://quay.io/repository/fenicsproject/stable/status
            :target: https://quay.io/repository/fenicsproject/stable
.. |dev-env| image:: https://quay.io/repository/fenicsproject/dev-env/status
             :target: https://quay.io/repository/fenicsproject/dev-env
.. |dev-env-dbg| image:: https://quay.io/repository/fenicsproject/dev-env-dbg/status
                 :target: https://quay.io/repository/fenicsproject/dev-env-dbg
.. |dev-env-trilinos| image:: https://quay.io/repository/fenicsproject/dev-env-trilinos/status
                      :target: https://quay.io/repository/fenicsproject/dev-env-trilinos
.. |base| image:: https://quay.io/repository/fenicsproject/base/status
          :target: https://quay.io/repository/fenicsproject/base
.. |dev-env-base| image:: https://quay.io/repository/fenicsproject/dev-env-base/status
                  :target: https://quay.io/repository/fenicsproject/dev-env-base

.. note:: Looking for images with dolfin-adjoint? Check out https://bitbucket.org/dolfin-adjoint/virtual.

+--------------------------+----------------------+-------------------------------------------------+
| **Image name**           | **Build status**     | **Short Description**                           |
+--------------------------+----------------------+-------------------------------------------------+
| ``stable``               | |stable|             | Stable release, with PETSc and SLEPc.           |
+--------------------------+----------------------+-------------------------------------------------+
| ``dev-env``              | |dev-env|            | Development environment with PETSc and SLEPc.   |
+--------------------------+----------------------+-------------------------------------------------+
| ``dev-env-dbg``          | |dev-env-dbg|        | As ``dev-env``, but with debugging symbols.     |
+--------------------------+----------------------+-------------------------------------------------+
| ``dev-env-trilinos``     | |dev-env-trilinos|   | As ``dev-env``, but with Trilinos.              |
+--------------------------+----------------------+-------------------------------------------------+
| ``base``                 | |base|               | Base image, not for end users.                  |
+--------------------------+----------------------+-------------------------------------------------+
| ``dev-env-base``         | |dev-env-base|       | Base image, not for end users.                  |
+--------------------------+----------------------+-------------------------------------------------+

.. note:: The *Build Status* column refers to the latest *attempted* build. Even if a build is marked
          as failed, there will still be a working image on the ``latest`` tag that you can use.

Detailed image descriptions
---------------------------

FEniCS library images
^^^^^^^^^^^^^^^^^^^^^

Application images are designed for typical end-users. Most users are
probably looking for the ``stable`` image:

* ``stable``: Provides the most recent release of FEniCS and is
  recommended for users who need the latest versions of PETSc, SLEPc,
  petsc4py and slepc4py.

Development and advanced images
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Developers and more advanced users may be interested in the following
images:

* ``dev-env``: Provides a development environment in which a user can
  compile FEniCS easily. It provides the necessary dependencies for
  FEniCS, but does not provide the FEniCS libraries themselves.

* ``dev-env-dbg``: Identical to ``dev-env``, except that SLEPc and
  PETSc are compiled with debugging symbols.

* ``dev-env-trilinos``: Identical to ``dev-env``, except that Trilinos
  is also compiled.
