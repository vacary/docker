Images
======

We currently offer seven end-user images.

Summary of available images
---------------------------

.. |stable| image:: https://quay.io/repository/fenicsproject/stable/status
            :target: https://quay.io/repository/fenicsproject/stable
.. |dolfin-adjoint| image:: https://quay.io/repository/fenicsproject/dolfin-adjoint/status
                    :target: https://quay.io/repository/fenicsproject/dolfin-adjoint
.. |dev| image:: https://quay.io/repository/fenicsproject/dev/status
         :target: https://quay.io/repository/fenicsproject/dev
.. |dev-env| image:: https://quay.io/repository/fenicsproject/dev-env/status
             :target: https://quay.io/repository/fenicsproject/dev-env
.. |dev-env-dbg| image:: https://quay.io/repository/fenicsproject/dev-env-dbg/status
                 :target: https://quay.io/repository/fenicsproject/dev-env-dbg
.. |dev-env-trilinos| image:: https://quay.io/repository/fenicsproject/dev-env-trilinos/status
                      :target: https://quay.io/repository/fenicsproject/dev-env-trilinos
.. |dev-env-py3| image:: https://quay.io/repository/fenicsproject/dev-env-py3/status
                 :target: https://quay.io/repository/fenicsproject/dev-env-py3
.. |dev-py3| image:: https://quay.io/repository/fenicsproject/dev-py3/status
             :target: https://quay.io/repository/fenicsproject/dev-py3
.. |base| image:: https://quay.io/repository/fenicsproject/base/status
          :target: https://quay.io/repository/fenicsproject/base
.. |dev-env-base| image:: https://quay.io/repository/fenicsproject/dev-env-base/status
                  :target: https://quay.io/repository/fenicsproject/dev-env-base

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
| dev-py3          | |dev-py3|           | As `dev`, but with Python 3.                  |
+------------------+---------------------+-----------------------------------------------+
| base             | |base|              | Base image, not for end users.                |
+------------------+---------------------+-----------------------------------------------+
| dev-env-base     | |dev-env-base|      | Base image, not for end users.                |
+------------------+---------------------+-----------------------------------------------+


Image descriptions
------------------

FEniCS library images
^^^^^^^^^^^^^^^^^^^^^

Application images are designed for typical end-users. Most users are
probably looking for either the `stable` or `dolfin-adjoint` images.

* `stable`: Provides the most recent release of FEniCS and is
  recommended for users who need the latest versions of PETSc, SLEPc,
  petsc4py and slepc4py.

* `dolfin-adjoint`: Identical to stable, but includes dolfin-adjoint_.

.. _dolfin-adjoint: http://dolfin-adjoint.org


Development and advanced images
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

Developers and more advanced users may be interested in the following
images:

* `dev`: Provides the latest development version of FEniCS. It is for
  users looking for the latest features.

* `dev-env`: Provides a development environment in which a user can
  compile FEniCS easily. It provides the necessary dependencies for
  FEniCS, but does not provide the FEniCS libraries themselves.

* `dev-env-dbg`: Identical to `dev-env`, except that SLEPc and PETSc
  are compiled with debugging symbols.

* `dev-env-trilinos`: Identical to `dev-env`, except that Trilinos is
  also compiled.

* `dev-env-py3`: Identical to `dev-env`, except with Python 3.

* `dev-py3`: Identical to `dev`, except with Python 3.
