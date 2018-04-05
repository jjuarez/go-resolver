package main

import (
	"flag"
	"fmt"
	"net"
	"os"
)

func main() {
	hostPtr := flag.String("host", "empty", "The host name to resolv")
	flag.Parse()

	if *hostPtr != "empty" {
		ip_address, err := net.LookupHost(*hostPtr)

		if err != nil {
			fmt.Printf("Oug! something goes wrong %s\n", err)
			os.Exit(1)
		}

		fmt.Printf("Resolved IP address: %s\n", ip_address)
	} else {
		fmt.Println("resolver -host=google.com")
		os.Exit(0)
	}
}
