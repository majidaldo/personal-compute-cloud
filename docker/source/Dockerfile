FROM ubuntu


RUN mkdir /src

RUN apt-get install -y git 

#program sources
ADD get_src.sh /

#dbl quotes!!
ENTRYPOINT ["/get_src.sh"] 

VOLUME /src

