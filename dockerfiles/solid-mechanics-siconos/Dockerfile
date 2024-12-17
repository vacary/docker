FROM fenics-solid-mechanics

USER root

RUN  apt update  && apt install -y -qq \
        ntp \
        cmake \
        git-core \
        make \
        libboost-dev \
        libboost-filesystem-dev \
        libboost-timer-dev \
        libboost-chrono-dev \
        libgmp-dev \
        gcc \
        gfortran \
        g++ \
        libopenblas-dev \
        liblapacke-dev \
        libcppunit-dev \
        vim && apt autoclean -y && apt autoremove -y && rm -rf /var/lib/apt/lists/*


RUN apt update  && apt upgrade -y &&  apt install -y -qq \
        lp-solve \
        liblpsolve55-dev \
        libhdf5-dev \
        libboost-serialization-dev \
        libfreetype6-dev \
        freeglut3-dev \
 	libxrender1 \
        python3-h5py && apt autoclean -y && apt autoremove -y&& rm -rf /var/lib/apt/lists/*


# RUN sh /home/install_fclib.sh
RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install -U vtk
#WORKDIR /home
#COPY ci_gitlab/dockerfiles/install_bullet.sh .
#ENV CI_PROJECT_DIR /home
#RUN sh /home/install_bullet.sh
#RUN apt clean && apt autoremove && rm -rf /var/lib/apt/lists/*





# install swig 4.0 
USER root
WORKDIR /home/root/
RUN apt update &&  apt install  -y -qq build-essential libpcre3-dev libpcre2-dev autotools-dev automake \
    && apt autoclean -y && apt autoremove -y&& rm -rf /var/lib/apt/lists/*
RUN mkdir tmp && cd tmp
WORKDIR /home/root/tmp
RUN wget http://ftp.gnu.org/gnu/bison/bison-3.5.tar.gz
RUN tar -xvf bison-3.5.tar.gz
RUN cd bison-3.5 && ./configure --prefix=/usr/local/bison --with-libiconv-prefix=/usr/local/libiconv/ &&  make && make install


RUN wget https://github.com/swig/swig/archive/refs/tags/v4.2.0.tar.gz
RUN tar -xvf v4.2.0.tar.gz
RUN cd swig-4.2.0 && ./autogen.sh && ./configure && make && make install
RUN rm -rf /home/root/tmp/swig-4.0.2

# install siconos
USER fenics
WORKDIR $FENICS_HOME
RUN git clone https://github.com/siconos/siconos.git
RUN cd siconos
WORKDIR /home/fenics/siconos
RUN mkdir build && cd build
WORKDIR /home/fenics/siconos/build
RUN cmake ..
#RUN make -j4

USER root