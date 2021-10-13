package pkg

import (
	"context"
	"log"
	"net"

	"google.golang.org/grpc"

	gen "go-grpc-poc/gen/hello/proto/proto"
)

type HelloService struct {
	gen.UnimplementedGreeterServer
}

func NewServer() *HelloService {
	return &HelloService{}
}

func (s *HelloService) SayHello(ctx context.Context, in *gen.HelloRequest) (*gen.HelloReply, error) {
	return &gen.HelloReply{Message: in.Name + " world"}, nil
}

func CreateRPCServer(addr string) (*grpc.Server, *net.Listener) {
	// Create a listener on TCP port
	lis, err := net.Listen("tcp", addr)
	if err != nil {
		log.Fatalln("Failed to listen:", err)
	}

	// Create a gRPC server object
	s := grpc.NewServer()
	// Attach the Greeter service to the server
	gen.RegisterGreeterServer(s, &HelloService{})
	return s, &lis

}
