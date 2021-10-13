
generate:
	@buf generate -o gen/hello/. --path proto/hello.proto

generate-protoc:
	@protoc -I ./proto \
		-I$(GOPATH)/pkg/mod/github.com/grpc-ecosystem/grpc-gateway\@v1.16.0/third_party/googleapis \
		--go_out ./gen --go_opt paths=source_relative \
		--go-grpc_out ./gen --go-grpc_opt paths=source_relative \
		./proto/hello.proto

run:
	@go build . && ./go-grpc-poc