FROM ubuntu

#deps

RUN apt-get -y update
RUN apt-get install -y git wget


RUN wget http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
RUN mv Miniconda-latest-Linux-x86_64.sh miniconda.sh
RUN bash miniconda.sh -b -p /anaconda && rm miniconda.sh
ENV PATH /anaconda/bin:$PATH

RUN conda install -y pip
RUN conda install -y numpy
RUN conda install -y scipy
