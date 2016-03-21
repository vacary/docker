.. A few notes for developers. Anything not of real importance
.. to end users.

.. _developer_notes:

Developer Notes
===============

The image ``base`` defines the end-user experience for all containers,
including creating the ``fenics`` user, setting default ``ENTRYPOINT`` and
``CMD`` variables, and setting the version of ``phusion/baseimage`` to use. All
other images should ultimately inherit ``FROM`` this image.

The image ``dev-env-base`` includes the ``fenics.conf`` helper script, the
``fenics.env.conf`` environment variable script, and sets the version numbers
of the packages to compile in the child images. All ``dev-env-{variant}``
should inherit ``FROM`` this image.
