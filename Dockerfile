FROM centos:7

MAINTAINER pirlo san <itstudying@hotmail.com>

# install gcc
# -y means saying yes to all questions
# 因为golang可能依赖于gcc，因此需要先安装gcc
RUN yum install -y go

# config GOROOT
ENV GOROOT /usr/lib/golang
ENV PATH=$PATH:/usr/lib/golang/bin

# config GOPATH
RUN mkdir -p /root/gopath
RUN mkdir -p /root/gopath/src
RUN mkdir -p /root/gopath/pkg
RUN mkdir -p /root/gopath/bin
ENV GOPATH /root/gopath

# copy source files
RUN mkdir -p /root/gopath/src/lijq-introduce/src
COPY src /root/gopath/src/lijq-introduce/src

# build the server
WORKDIR /root/gopath/src/lijq-introduce/src
RUN go build -o server.bin main.go

# startup the server
CMD /root/gopath/src/lijq-introduce/src/server.bin