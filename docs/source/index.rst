.. FEniCS Containers documentation master file, created by
   sphinx-quickstart on Sun Mar 13 10:22:20 2016.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

=============================
FEniCS in Containers - Docker
=============================

This is the documentation for Linux/Docker containers for the FEniCS
libraries from the `FEniCS Project <http://fenicsproject.org>`_.
Containers provide a consistent and portable FEniCS environment, for
both running FEniCS applications and developing FEniCS. On modern
Linux systems there is no performance penalty when running in a
container compared to running natively on the host system. In many
cases, the container versions of FEniCS are faster than user
installations as the containers have been tuned for performance by the
FEniCS developers. On non-Linux based systems, the containers will run
inside a virtual machine are still fast.

The Docker images are automatically built on quay.io at
https://quay.io/repository/fenicsproject/. The Dockerfiles for the
containers are maintained on `Bitbucket
<https://bitbucket.org/fenics-project/docker>`_. Images are provided
of both release and development versions of FEniCS.

.. note:

   This documentation is under development.


.. toctree::
   :maxdepth: 2

   getting_started
   images
   work_flows
   jupyter
   developing



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
