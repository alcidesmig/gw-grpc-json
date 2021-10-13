package main

import (
	"go-grpc-poc/pkg"
	"log"
)

func main() {
	log.Println("Starting...")

	go func(addr string) {
		srv, lis := pkg.CreateRPCServer(addr)
		// Serve gRPC server
		log.Printf("Serving gRPC on %s", addr)
		log.Fatalln(srv.Serve(*lis))
	}("0.0.0.0:8080")

	func(rpcAddr, gwAddr string) {
		gw := pkg.CreateGateway(rpcAddr, gwAddr)
		log.Printf("Serving gRPC-Gateway on %s\n", gw.Addr)
		log.Fatalln(gw.ListenAndServe())
	}("0.0.0.0:8080", "0.0.0.0:8090")
}
