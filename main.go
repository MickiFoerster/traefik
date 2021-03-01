package main

import (
	"log"
	"net/http"
	"os"
)

func main() {
	if len(os.Args) != 3 {
		log.Fatal("syntax error: Provide path to file to serve as first argument. The port is to be given as 2nd parameter.")
	}
	path := os.Args[1]
	port := os.Args[2]
	http.HandleFunc("/", func (w http.ResponseWriter, req *http.Request) {
		http.ServeFile(w, req, path)
	})
	log.Fatal(http.ListenAndServe(":"+port, nil))
}

