all: test build

build: deps
	go build -o ifcfg-api main.go

docker: docker/build docker/run

docker/build:
	docker build -t registry.svc.bluescripts.net/ifcfg/web .

docker/run:
	docker run -p 8080:8080 registry.svc.bluescripts.net/ifcfg/web

test: test/integration test/unit

test/convey:
	goconvey

test/unit:
	go test -v ./... -cover

dev:
	go run main.go

dev/race:
	go run -race main.go

lint:
	gometalinter ./... --disable=gotype --disable=gocyclo

linter/install:
	go get -u github.com/alecthomas/gometalinter
	gometalinter --install

deps:
	dep ensure
