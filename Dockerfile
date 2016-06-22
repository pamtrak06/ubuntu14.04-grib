FROM ubuntu:14.04
MAINTAINER pamtrak06@gmail.com
RUN apt-get update -y && apt-get install -y wget curl locate git
RUN apt-get install -y rpm build-essential cmake gfortran
RUN wget https://software.ecmwf.int/wiki/download/attachments/3473437/grib_api-1.15.0-Source.tar.gz?api=v2 -O grib_api-1.15.0-Source.tar.gz
RUN tar -xvf grib_api-1.15.0-Source.tar.gz
RUN mkdir /build && mkdir /gribapi
WORKDIR /build
RUN cmake  ../grib_api-1.15.0-Source  -DCMAKE_INSTALL_PREFIX=/gribapi
RUN make && ctest && make install
RUN updatedb
ENV PATH=$PATH:/gribapi
