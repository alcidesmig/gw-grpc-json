package main

import (
	"context"
	"fmt"
	gen "go-grpc-poc/gen/hello/proto/proto"
	"log"
	"net"

	"google.golang.org/grpc"
)

type HelloService struct {
	gen.GreeterServer
}

func (o *HelloService) SayHello(ctx context.Context, req *gen.HelloRequest) (*gen.HelloReply, error) {
	fmt.Printf("Received %v", *req)
	return &gen.HelloReply{Message: "Teste"}, nil
}

func main() {
	// Create a listener on TCP port
	lis, err := net.Listen("tcp", ":8080")
	if err != nil {
		log.Fatalln("Failed to listen:", err)
	}

	// Create a gRPC server object
	s := grpc.NewServer()
	// Attach the Greeter service to the server
	gen.RegisterGreeterServer(s, &HelloService{})
	// Serve gRPC Server
	log.Println("Serving gRPC on 0.0.0.0:8080")
	log.Fatal(s.Serve(lis))
}
