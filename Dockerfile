FROM ubuntu:14.04
MAINTAINER pamtrak06@gmail.com
RUN apt-get update -y && apt-get install -y wget curl locate git
RUN apt-get install -y rpm build-essential cmake gfortran
RUN apt-get install -y openjpeg-tools
ENV GRIBAPI_VERSION=1.15.0
#ENV GRIBAPI_VERSION=1.14.7
RUN wget https://software.ecmwf.int/wiki/download/attachments/3473437/grib_api-${GRIBAPI_VERSION}-Source.tar.gz?api=v2 -O grib_api-${GRIBAPI_VERSION}-Source.tar.gz
RUN tar -xvf grib_api-${GRIBAPI_VERSION}-Source.tar.gz
RUN mkdir /build && mkdir /gribapi

#WORKDIR /build
#RUN cmake  ../grib_api-${GRIBAPI_VERSION}-Source  -DCMAKE_INSTALL_PREFIX=/gribapi
##RUN make && ctest && make install
#RUN make && make install
#WORDIR /gribapi
WORKDIR /grib_api-${GRIBAPI_VERSION}-Source
#RUN ./configure --prefix=/gribapi --with-openjpeg="/usr/lib/x86_64-linux-gnu/libjpeg.so.8"
RUN ./configure --prefix=/gribapi --disable-jpeg
#RUN make && make check && make install
RUN make && make install
WORKDIR /gribapi

RUN updatedb
RUN chmod  755 /gribapi/bin/*
ENV PATH=$PATH:/gribapi/bin
VOLUME /gribapi
