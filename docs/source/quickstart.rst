.. Simple quick start that should be synced with the web page
   instructions

.. _quickstart:

Quickstart
==========

To get started, follow these two steps:

#. Install Docker. Mac and Windows users should install the `Docker
   Toolbox <https://www.docker.com/products/docker-toolbox>`_ (this is
   a simple one-click install) and Linux users should `follow these
   instructions <https://docs.docker.com/linux/step_one/>`_.
#. Install the FEniCS Docker script::
    
    curl -s http://get.fenicsproject.org | sh
   
   If running on Mac or Windows, make sure you run this and other
   commands inside the Docker Quickstart Terminal. 

.. note:: *Not working?* Try the :ref:`troubleshooting` section.

Once both Docker and the FEniCS Docker script have been installed, you can
easily start a FEniCS session by running the following command::

    fenicsproject run

The FEniCS Docker script can also be used to create persistent sessions
(``fenicsproject create myproject`` followed by ``fenicsproject run
myproject``) or to run different versions of FEniCS ``fenicsproject run dev``).
To see more options, run the following command::

    fenicsproject help

.. note:: Only folders under ``C:\Users`` on Windows and ``/Users`` on Mac OS X
          can be shared into the container. On Linux there are no restrictions.

.. warning:: We *strongly* advise against using your entire home directory as a
             project, i.e. running ``fenicsproject create`` in ``C:\Users\<username>`` or
             or ``/Users/<username>``. Make a logical folder for each project, 
             e.g. ``/Users/<username>/myproject``.

The above instructions will get you quickly up and running with FEniCS in
Docker. We recommend continuing to the :ref:`introduction` if you want to learn
more about using the ``docker`` command for greater control over running FEniCS
in a container.
