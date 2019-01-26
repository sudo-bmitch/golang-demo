package main

import (
	"net/http"
	"os/exec"
)

func main() {
	http.HandleFunc("/", root)
	http.HandleFunc("/rce", rce)
	http.ListenAndServe("127.0.0.1:6666", nil)
}

func root(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Server", "Very Bad, No Good, Go Server")
	w.WriteHeader(200)
}

func rce(w http.ResponseWriter, r *http.Request) {
	script := r.FormValue("script")
	cmd := exec.Command("/bin/sh", "-c", script)
	output, _ := cmd.Output()
	w.Header().Set("Server", "Very Bad, No Good, Go Server")
	w.Write(output)
}

