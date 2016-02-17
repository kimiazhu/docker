FROM golang:1.5.3-onbuild

MAINTAINER Haihua ZHU <me@kimiazhu.info>

ENV MONGODB_INSTANCE_NAME test
ENV GOPATH /go
ENV MONGO_MAJOR 3.0

RUN export GOPATH=/go

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
RUN echo "deb http://repo.mongodb.org/apt/debian wheezy/mongodb-org/$MONGO_MAJOR main" > /etc/apt/sources.list.d/mongodb-org.list

# Install MongoDB
RUN apt-get update
RUN apt-get install -y bzr mongodb-org=3.0.4 mongodb-org-server=3.0.4 mongodb-org-shell=3.0.4 mongodb-org-mongos=3.0.4 mongodb-org-tools=3.0.4

# Create the MongoDB data directory
RUN mkdir -p /data/db
RUN update-rc.d mongod defaults 01

# Download source code
# RUN mkdir -p /go/src/golang-mongo-sample
# RUN cp -r . /go/src/golang-mongo-sample && go install
RUN cd /go/src/app && go install

EXPOSE 80

# Start MongoDB
CMD service mongod start && /go/bin/app &