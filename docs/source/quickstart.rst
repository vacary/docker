.. Simple quick start that should be synced with the web page
   instructions

.. _quickstart:

Quickstart
==========

To get started, follow these two steps:

#. Install Docker for your platform by following `these
   instructions <https://docs.docker.com/engine/getstarted/step_one/>`_.
   Windows users must continue to use the Docker Toolbox, *not* Docker
   for Windows, if they wish to use the FEniCS Docker script described below.
#. Install the FEniCS Docker script::
    
    curl -s http://get.fenicsproject.org | sh
   
   If using the Docker Toolbox (macOS versions < 10.10 or Windows versions <
   10), make sure you run this and other commands inside the Docker Quickstart
   Terminal. 

.. note:: *Not working?* Try the :ref:`troubleshooting` section.

Once both Docker and the FEniCS Docker script have been installed, you can
easily start a FEniCS session by running the following command::

    fenicsproject run

The FEniCS Docker script can also be used to create persistent sessions
(``fenicsproject create myproject`` followed by ``fenicsproject run
myproject``) or to run different versions of FEniCS ``fenicsproject run dev``).

For all ``fenicsproject`` commands, the contents of the current directory will
be shared into the project at ``~/shared``.

.. note:: Only folders under ``C:\Users`` on Windows and ``/Users`` on macOS 
          can be shared into a project. On Linux there are no restrictions.

.. warning:: We *strongly* advise against sharing your entire home directory into a
             project, i.e. running ``fenicsproject create`` in ``C:\Users\<username>``
             or ``/Users/<username>``. Make a logical folder for each project, 
             e.g. ``/Users/<username>/myproject``.

To see more options, run the following command::

    fenicsproject help

The above instructions will get you quickly up and running with FEniCS in
Docker. We recommend continuing to the :ref:`introduction` if you want to learn
more about using the ``docker`` command for greater control over running FEniCS
in a container.
