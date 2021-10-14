# Run before running protoc-generate
bootstrap:
	@go get github.com/googleapis/googleapis\@v0.0.0-20211013172543-4a5dad747316
	@go get github.com/grpc-ecosystem/grpc-gateway\@v1.16.0
	@go get github.com/grpc-ecosystem/grpc-gateway/v2@v2.6.0

buf-generate:
	@buf generate -o gen/. --path ./proto

protoc-generate: bootstrap
	@mkdir -p gen/proto gen/openapi
	@protoc -I ./proto \
		-I$(GOPATH)/pkg/mod/github.com/grpc-ecosystem/grpc-gateway\@v1.16.0/third_party/googleapis \
		-I$(GOPATH)/pkg/mod/github.com/googleapis/googleapis\@v0.0.0-20211013172543-4a5dad747316 \
		-I$(GOPATH)/pkg/mod/github.com/grpc-ecosystem/grpc-gateway/v2@v2.6.0 \
		--go_out ./gen/proto --go_opt paths=source_relative \
		--go-grpc_out ./gen/proto --go-grpc_opt paths=source_relative \
		--grpc-gateway_out ./gen/proto \
		--grpc-gateway_opt logtostderr=true \
  		--grpc-gateway_opt paths=source_relative \
    	--grpc-gateway_opt generate_unbound_methods=true \
		--openapiv2_out . \
		--openapiv2_opt=allow_merge=true,merge_file_name=gen/openapi/openapi \
		./proto/*.proto

run:
	@go build -o out .  && ./out

test:
	@curl -X POST -k http://localhost:8090/v1/hello -d '{"x": "y", "name": "hello"}'

