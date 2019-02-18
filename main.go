package main

import (
	"fmt"
	"net/http"
	"os/exec"
)

func main() {
	http.HandleFunc("/", root)
	http.HandleFunc("/rce", rce)
	fmt.Print("Ready to receive requests on port 6666\n")
	http.ListenAndServe(":6666", nil)
}

func root(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Server", "Very Bad, No Good, Go Server")
	w.WriteHeader(200)
}

func rce(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Server", "Very Bad, No Good, Go Server")
	script := r.FormValue("script")
	fmt.Printf("Running: %s\n", script)
	cmd := exec.Command("/bin/sh", "-c", script)
	output, err := cmd.CombinedOutput()
	if err != nil {
		msg := fmt.Sprintf("%s\n", err.Error())
		w.Write([]byte(msg))
	} else {
		w.Write(output)
	}
}

