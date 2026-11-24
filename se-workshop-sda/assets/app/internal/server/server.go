// Package server serves the chosen flavor's page and the small JSON API it polls.
package server

import (
	"encoding/json"
	"io/fs"
	"net/http"
	"os"
	"time"

	"sda-showcase/internal/brand"
	"sda-showcase/internal/market"
)

var startTime = time.Now()

func New(cfg brand.Config, web fs.FS) http.Handler {
	mux := http.NewServeMux()
	page, _ := fs.ReadFile(web, cfg.Flavor+".html")

	mux.HandleFunc("GET /{$}", func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "text/html; charset=utf-8")
		w.Write(page)
	})
	mux.Handle("GET /static/", http.StripPrefix("/static/", http.FileServerFS(web)))

	mux.HandleFunc("GET /api/config", func(w http.ResponseWriter, r *http.Request) {
		writeJSON(w, http.StatusOK, cfg)
	})
	mux.HandleFunc("GET /api/quotes", func(w http.ResponseWriter, r *http.Request) {
		writeJSON(w, http.StatusOK, market.Board(cfg.Symbols, time.Now()))
	})
	mux.HandleFunc("GET /version", func(w http.ResponseWriter, r *http.Request) {
		host, _ := os.Hostname()
		writeJSON(w, http.StatusOK, map[string]any{
			"version":     cfg.Version,
			"flavor":      cfg.Flavor,
			"hostname":    host,
			"environment": getenv("DEPLOY_ENV", "local"),
			"build":       os.Getenv("BUILD"),
			"healthy":     cfg.Healthy(),
		})
	})

	// /health is what a deployment pipeline should verify. It fails when showcase.yaml says
	// release.healthy: false, which is how the workshop ships a "bad" release on purpose.
	mux.HandleFunc("GET /health", func(w http.ResponseWriter, r *http.Request) {
		if !cfg.Healthy() {
			writeJSON(w, http.StatusServiceUnavailable, map[string]any{
				"status":  "unhealthy",
				"version": cfg.Version,
				"reason":  "release.healthy is false in showcase.yaml",
			})
			return
		}
		writeJSON(w, http.StatusOK, map[string]any{
			"status":  "healthy",
			"version": cfg.Version,
			"uptime":  time.Since(startTime).Round(time.Second).String(),
		})
	})

	// /ready is for Kubernetes probes. It stays up for a bad release so the pod takes traffic
	// and the pipeline's health check, not a probe timeout, is what catches it.
	mux.HandleFunc("GET /ready", func(w http.ResponseWriter, r *http.Request) {
		writeJSON(w, http.StatusOK, map[string]string{"status": "ready"})
	})
	return mux
}

func writeJSON(w http.ResponseWriter, code int, v any) {
	w.Header().Set("Content-Type", "application/json")
	w.Header().Set("Cache-Control", "no-store")
	w.WriteHeader(code)
	json.NewEncoder(w).Encode(v)
}

func getenv(key, fallback string) string {
	if v := os.Getenv(key); v != "" {
		return v
	}
	return fallback
}
