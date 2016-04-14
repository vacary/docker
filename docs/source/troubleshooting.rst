.. Troubleshooting section where we can collate *common* issues.

.. _troubleshooting:

Troubleshooting
===============

I can't access the internet in the container
--------------------------------------------

Docker images default to using the Google Domain Name Servers (DNS). Access to
these may be blocked on some networks, resulting in no internet access in the
container. In this case, you can set the address of the DNS using the Docker
option ``--dns``, e.g.::

    docker run --dns=4.4.4.4 -ti fenicsproject/dev-env:latest

and replace ``4.4.4.4`` with the address of your local DNS.

For setting the DNS system-wide, see
<https://docs.docker.com/engine/admin/systemd/> and
<https://stackoverflow.com/questions/33784295/setting-dns-for-docker-daemon-using-systemd-drop-in/>.

I can't share a folder into the container
-----------------------------------------

*Mac OS X*: By default, only files and directories under  ``/Users/`` can be
shared into a container using the ``-v`` flag.

*Windows*: By default, only files and directories under ``C:\Users`` can be
shared into a container using the ``-v`` flag.

I've run out of space for new containers or images
--------------------------------------------------

Users running on Mac OS X and Windows are actually running the Docker
containers inside a Virtual Machine. If you ``pull`` too many images from
Dockerhub then you may fill up the virtual machine's disk drive.

You can see how much space you have left using the following command::

    docker-machine ssh $(docker-machine active) sudo df -h /dev/sda1

You should see something like this::

    Filesystem                Size      Used Available Use% Mounted on
    /dev/sda1                75.8G     45.8G     26.2G  64% /mnt/sda1

If the ``Use%`` column is greater than 90%, then you should follow the
steps outlined below. Remember that files shared into the container
from the host will `not` be deleted when you delete a container.

To cleanup, you first need to remove containers you are no longer using. To
list all containers, type::

    docker ps -a

You can then remove unwanted containers using::

    docker rm <name>

where ``<name>`` is the name of the container shown in the output of ``docker
ps -a``. Note that containers typically do not take up much space, but the
images they are based on can be hundreds of megabytes each.

Now, you can clean up unused or dangling images (images not associated with a
container) by running::

    docker rmi $(docker images -q --filter "dangling=true")

Note that if an image is associated with a container it cannot be deleted. So
it is important to ``rm`` some containers first.

Still not working?
------------------

Support requests can be sent to the FEniCS Support mailing list
(fenics-support@googlegroups.com).
