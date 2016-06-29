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

Docker for Mac, Docker for Windows and Linux users
--------------------------------------------------
First of all we ``run`` a new Docker container with the ``jupyter-notebook``
command specified and the default port ``8888`` exposed on ``localhost``::

    docker run --name notebook -w /home/fenics/shared -v $(pwd):/home/fenics/shared -d -p 127.0.0.1:8888:8888 quay.io/fenicsproject/stable 'jupyter-notebook --ip=0.0.0.0'

The notebook will be available at ``http://localhost:8888`` in your web browser.

Docker Toolbox for Windows and Mac users
----------------------------------------

First of all we ``run`` a new Docker container with the ``jupyter-notebook``
command specified and the default port ``8888`` exposed on the IP of the
virtual machine where docker is running::

    docker run --name notebook -w /home/fenics/shared -v $(pwd):/home/fenics/shared -d -p $(docker-machine ip $(docker-machine active)):8888:8888 quay.io/fenicsproject/stable 'jupyter-notebook --ip=0.0.0.0'

To find out the IP of the virtual machine::

    docker-machine ip $(docker-machine active)

The notebook will be available at ``http://<ip-of-virtual-machine>:8888`` in
your web browser.

.. note:: All images except ``base`` and ``dev-env-base`` include Jupyter.

Further instructions
--------------------

The current working directory ``$(pwd)`` will be available in the Jupyter
notebook interface. You might want to give the container a name that
you can easily rememember. In this example I have simply chosen ``notebook``.

.. note:: This setup is secure by default. Users on your local network cannot
          access the web interface, even if they know your IP address.

With the flag ``-d`` we have placed the container into daemon mode. It will continue
to run in the background until we ``stop`` it::

    docker stop notebook

To start it again just run::

    docker start notebook

If you want to see the log output from the Jupyter notebook server type::

    docker logs notebook 
