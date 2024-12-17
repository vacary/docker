FROM fenics-stable

USER ROOT

USER fenics
WORKDIR $FENICS_HOME

# install Mosek
RUN pip install -f https://download.mosek.com/stable/wheel/index.html Mosek --user

# install fenics_optim
RUN git clone https://gitlab.enpc.fr/navier-fenics/fenics-optim.git &&\
    cd fenics-optim && \
    python3 setup.py install --user
    
# install fenics_shell
RUN git clone https://bitbucket.org/unilucompmech/fenics-shells.git && \
    cd fenics-shells &&  \
    python3 setup.py develop --user && \
    cd demo && \
    python3 generate-demos.py

USER root

# install fenics_mpm

RUN mkdir tmp
WORKDIR /home/fenics/tmp
RUN curl -OL https://cmake.org/files/v3.14/cmake-3.14.7.tar.gz
RUN tar -xzvf cmake-3.14.7.tar.gz

WORKDIR /home/fenics/tmp/cmake-3.14.7
RUN /bin/bash bootstrap -- -DCMAKE_BUILD_TYPE:STRING=Release
RUN make -j4
RUN make install

WORKDIR $FENICS_HOME
RUN rm -rf tmp

USER fenics
RUN pip install colored termcolor --user
RUN git clone https://github.com/pf4d/fenics_mpm.git
RUN cd fenics_mpm/cpp &&  \
    mkdir build && \
    cd build && \
    cmake .. -DCMAKE_INSTALL_PREFIX=~/.local && \
    make -j4 && \
    make install

RUN cd fenics_mpm/python &&  \
    export CMAKE_PREFIX_PATH=/home/fenics/.local:$CMAKE_PREFIX_PATH && \
    pip install -e .


# install additional python packages
RUN pip install meshio multiphenics  --user
RUN pip install pygmsh   --user



### addons for mananing xdmf files in python
USER root
RUN apt-get -y install python3-h5py
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*



USER root












