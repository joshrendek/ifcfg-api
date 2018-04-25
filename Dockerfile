FROM golang:1.10-alpine as build-env
RUN apk add --update curl build-base git
RUN curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh
ADD . /go/src/github.com/joshrendek/ifcfg
WORKDIR /go/src/github.com/joshrendek/ifcfg
RUN make build

FROM alpine:3.7
WORKDIR /app
ENV PORT 8080
COPY --from=build-env /go/src/github.com/joshrendek/ifcfg/ifcfg-api /app/ifcfg-api
ADD views .
ENTRYPOINT ["./ifcfg-api"]
