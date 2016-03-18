.. Performance inside containers

Performance
===========

Linux
-----

On modern Linux systems there is no performance penalty when running
FEniCS in Docker, compared to running natively on the host system.  In
practice, the containers are usually faster than user installations
because they have been tuned for performance.

Mac and Windows
---------------

On Mac or Windows, Docker will run inside a virtual machine.  Running
FEniCS in Docker may actually be faster than using a native build
since our Docker images have been tuned for performance.
