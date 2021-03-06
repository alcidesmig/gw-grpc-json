# go-grpc-poc

This project aims to explore the gRPC world, focused in communication with servers through one API gateway, code generation from .protoc files and code enrichment from protobuf annotations

## Dependencies

In order to generate the gRPC, protobuf and gRPC-gateway code with `protoc`, these projects are necessary:
- https://github.com/googleapis/googleapis
- https://github.com/grpc-ecosystem/grpc-gateway @ v1.16.0 & v2.6.0

And can be achieved through golang dependency management tool by running `make bootstrap`. Then, code can be generated by `make protoc-generate`.

To generate code with `buf` (https://github.com/bufbuild/buf) it's only necessary to call `make buf-generate`, and the tool will manage the deps for you.

## Gateway & gRPC server implementations

In progress

## tree

```
.
├── buf.gen.yaml # buf configuration fule
├── buf.lock     # buf configuration fule
├── buf.yaml     # buf configuration fule
├── gen
│   ├── openapi  # generated openapi spec
│   │   └── openapi.swagger.json
│   └── proto    # generated golang code (gw+grpc+protobuf)
│       ├── hello_grpc.pb.go
│       ├── hello.pb.go
│       ├── hello.pb.gw.go
│       ├── user_grpc.pb.go
│       ├── user.pb.go
│       └── user.pb.gw.go
├── go.mod
├── go.sum
├── main.go
├── Makefile
├── pkg           # code implementing gateway and grpc server
│   ├── gateway.go
│   └── server.go
├── proto         # protobuf specs
│   ├── hello.proto
│   └── user.proto
└── README.md
```