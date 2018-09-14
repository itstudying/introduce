FROM golang

MAINTAINER lijq <itstudying@hotmail.com>

COPY src /go/src/lijq-introduce/src

# build the server
WORKDIR /go/src/lijq-introduce/src
RUN go get -u github.com/golang/dep/cmd/dep && dep ensure && go build -o server.bin main.go

# startup the server
CMD /go/src/lijq-introduce/src/server.bin