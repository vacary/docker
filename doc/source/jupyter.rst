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

    docker run --name notebook -w /home/fenics -v $(pwd):/home/fenics/shared -d -p 127.0.0.1:8888:8888 quay.io/fenicsproject/stable 'jupyter-notebook --ip=0.0.0.0'

The notebook will be available at ``http://localhost:8888`` in your web browser.

Docker Toolbox for Windows and Mac users
----------------------------------------

First of all we ``run`` a new Docker container with the ``jupyter-notebook``
command specified and the default port ``8888`` exposed on the IP of the
virtual machine where docker is running::

    docker run --name notebook -w /home/fenics -v $(pwd):/home/fenics/shared -d -p $(docker-machine ip $(docker-machine active)):8888:8888 quay.io/fenicsproject/stable 'jupyter-notebook --ip=0.0.0.0'

To find out the IP of the virtual machine::

    docker-machine ip $(docker-machine active)

The notebook will be available at ``http://<ip-of-virtual-machine>:8888`` in
your web browser.

.. note:: All images except ``base`` and ``dev-env-base`` include Jupyter.

Plotting
--------

Basic two and three-dimensional plotting are available from within the Jupyter
notebook.

To see an example of what's possible check out :download:`this notebook
<jupyter-fenics-plotting-example.html>`.

.. note:: Safari and Firefox are currently recommended for 3D plotting. Chrome
          has an intermittent issue where plots may not render.

For `matplotlib`_ plotting (2D), open up a new Jupyter notebook, and in the
first cell type::

    %matplotlib inline

Execute (Shift-Enter) the cell. In the next cell, we will load in the code from
the DOLFIN Python Poisson demo::

    %load ~/demo/documented/poisson/python/demo_poisson.py

Execute (Shift-Enter) the cell. In the same cell, the code from the
``demo_poisson.py`` file will be shown. Click in the cell and execute
(Shift-Enter) again. A plot of the solution variable ``u`` will appear.

For `X3DOM`_ plotting (3D), continuing from above, in a new cell type::

    from IPython.display import HTML
    HTML(X3DOM().html(u))

Execute (Shift-Enter) the cell. A 3D plot will appear that you can rotate
and zoom using the mouse.

.. _matplotlib: http://matplotlib.org
.. _X3DOM: http://www.x3dom.org

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
