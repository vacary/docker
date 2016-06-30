.. Performance inside containers

Performance
===========

In short, running FEniCS in Docker may actually be faster than using a native
build since our Docker images have been tuned for performance, even when
running Docker using virtualisation technologies on Mac and Windows.

Linux
-----

On modern Linux systems there is no performance penalty when running
FEniCS in Docker, compared to running natively on the host system.  In
practice, the containers are usually faster than user installations
because they have been tuned for performance.

Docker for Mac
---------------

On macOS, Docker runs inside an extremely lightweight hypervisor provided by
Apple's Hypervisor framework. 

Docker for Windows
------------------

On Windows, Docker runs inside Microsoft's Hyper-V, a native and lightweight
hypervisor technology. 

Docker Toolbox
--------------

On Mac or Windows, Docker runs inside a Virtualbox-based virtual machine.
