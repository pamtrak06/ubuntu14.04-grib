FROM ubuntu:14.04
MAINTAINER pamtrak06@gmail.com
RUN apt-get update -y && apt-get install -y wget curl locate git
RUN apt-get install -y rpm build-essential cmake gfortran
ENV GRIBAPI_VERSION=1.15.0
#ENV GRIBAPI_VERSION=1.14.7
RUN wget https://software.ecmwf.int/wiki/download/attachments/3473437/grib_api-${GRIBAPI_VERSION}-Source.tar.gz?api=v2 -O grib_api-${GRIBAPI_VERSION}-Source.tar.gz
RUN tar -xvf grib_api-${GRIBAPI_VERSION}-Source.tar.gz
RUN mkdir /build && mkdir /gribapi
WORKDIR /build
RUN cmake  ../grib_api-${GRIBAPI_VERSION}-Source  -DCMAKE_INSTALL_PREFIX=/gribapi
#RUN make && ctest && make install
RUN make && make install
RUN updatedb
RUN chmod  755 /gribapi/bin/*
ENV PATH=$PATH:/gribapi/bin
VOLUME /gribapi
WORDIR /gribapi
