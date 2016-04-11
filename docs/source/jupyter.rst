.. Documentation for using a container to run a Jupyter notebook

Running Jupyter notebooks
=========================

Jupyter notebooks allow you to create and share documents that contain live
code, equations and visualisations. For more information check out
https://jupyter.org.

It only takes two commands to get a Jupyter notebook up and running with
a FEniCS environment installed.

.. note:: The ``fenicsproject notebook myproject`` command automates the tasks
          outlined below. See :ref:`quickstart` for instructions.

First of all we ``run`` a new Docker container with the ``jupyter-notebook``
command specified and the default port ``8888`` forwarded to the host::

    docker run --name notebook -w /home/fenics/shared -v $(pwd):/home/fenics/shared -d -p 127.0.0.1:8888:8888 quay.io/fenicsproject/stable 'jupyter-notebook --ip=0.0.0.0'

.. note:: All images except ``base`` and ``dev-env-base`` include Jupyter.

The current working directory ``$(pwd)`` will be available in the Jupyter
notebook interface. You might want to give the container a name that
you can easily rememember. In this example I have simply chosen ``notebook``.

In addition to the ``docker run`` command users on Mac OS X and Windows will
need to setup an SSH tunnel between the host and the virtual machine where
Docker actually runs:: 

    docker-machine ssh $(docker-machine active) -fN -L localhost:8888:localhost:8888

You should now be able to access the notebook using your web browser at
http://localhost:8888.

.. note:: This setup is secure by default; the Docker container where Jupyter runs is
          completely isolated from the host system and only exposed on the local 
          interface. Users on your local network cannot access the
          web interface, even if they know your IP address.

With the flag ``-d`` we have placed the container into daemon mode. It will continue
to run in the background until we ``stop`` it::

    docker stop notebook

To start it again just run::

    docker start notebook

If you have restarted your Windows or OS X computer, remember that you will
need to setup your SSH tunnel again::

    docker-machine ssh $(docker-machine active) -fN -L localhost:8888:localhost:8888

If you want to see the log output from the Jupyter notebook server type::

    docker logs notebook 

