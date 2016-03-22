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

Still not working?
------------------

Support requests can be sent to the FEniCS Support mailing list
(fenics-support@googlegroups.com).
