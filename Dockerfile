# syntax=docker/dockerfile:1

FROM golang:alpine as builder

MAINTAINER lwnmengjing

ENV GOPROXY https://goproxy.cn/

WORKDIR /go/release
#RUN sed -i 's/dl-cdn.alpinelinux.org/mirrors.aliyun.com/g' /etc/apk/repositories
RUN apk update && apk add tzdata

COPY go.mod ./go.mod
RUN go mod tidy
COPY . .
RUN pwd && ls
RUN echo $GOPATH

RUN go build github.com/cloudwebrtc/flutter-webrtc-server/cmd/server

EXPOSE 8086

CMD ["./server"]