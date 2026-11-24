// sda-showcase is the app students ship in the Harness Software Delivery Agent workshop.
// Everything a student customizes lives in showcase.yaml, which is built into the binary,
// so every change has to travel through the pipeline to reach the cluster.
package main

import (
	"embed"
	"io/fs"
	"log"
	"net/http"
	"os"

	"sda-showcase/internal/brand"
	"sda-showcase/internal/server"
)

//go:embed showcase.yaml
var showcaseYAML []byte

//go:embed web
var webFiles embed.FS

func main() {
	cfg, err := brand.Parse(showcaseYAML)
	if err != nil {
		log.Fatalf("showcase.yaml: %v", err)
	}
	web, _ := fs.Sub(webFiles, "web")

	port := os.Getenv("PORT")
	if port == "" {
		port = "8080"
	}
	log.Printf("sda-showcase %s (%s flavor) listening on :%s", cfg.Version, cfg.Flavor, port)
	log.Fatal(http.ListenAndServe(":"+port, server.New(cfg, web)))
}
