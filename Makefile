buf-generate:
	@buf generate -o gen/hello/. --path proto/hello.proto

protoc-generate:
	@protoc -I ./proto \
		-I$(GOPATH)/pkg/mod/github.com/grpc-ecosystem/grpc-gateway\@v1.16.0/third_party/googleapis \
		--go_out ./gen --go_opt paths=source_relative \
		--go-grpc_out ./gen --go-grpc_opt paths=source_relative \
		./proto/hello.proto

run:
	@go build . -o go-grpc-poc && ./go-grpc-poc

test:
	@curl -X POST -k http://localhost:8090/v1/hello -d '{"x": "y", "name": "hello"}'