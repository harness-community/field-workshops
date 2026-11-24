package server

import (
	"encoding/json"
	"net/http"
	"net/http/httptest"
	"strings"
	"testing"
	"testing/fstest"

	"sda-showcase/internal/brand"
)

var web = fstest.MapFS{
	"ticker.html":    {Data: []byte("<h1>ticker</h1>")},
	"billboard.html": {Data: []byte("<h1>billboard</h1>")},
	"shared.js":      {Data: []byte("// shared")},
}

func config(t *testing.T, doc string) brand.Config {
	t.Helper()
	c, err := brand.Parse([]byte(doc))
	if err != nil {
		t.Fatal(err)
	}
	return c
}

func get(h http.Handler, path string) *httptest.ResponseRecorder {
	w := httptest.NewRecorder()
	h.ServeHTTP(w, httptest.NewRequest("GET", path, nil))
	return w
}

func TestServesChosenFlavor(t *testing.T) {
	for _, flavor := range brand.Flavors {
		h := New(config(t, "flavor: "+flavor+"\nname: x\naccent: \"#112233\"\nsymbols: [USDJPY]\n"), web)
		if w := get(h, "/"); w.Code != 200 || !strings.Contains(w.Body.String(), flavor) {
			t.Errorf("%s: GET / = %d %q", flavor, w.Code, w.Body.String())
		}
	}
}

func TestHealth(t *testing.T) {
	h := New(config(t, "name: x\naccent: \"#112233\"\nsymbols: [USDJPY]\nversion: 2.0.0\n"), web)
	w := get(h, "/health")
	var body map[string]any
	json.Unmarshal(w.Body.Bytes(), &body)
	if w.Code != 200 || body["status"] != "healthy" || body["version"] != "2.0.0" {
		t.Fatalf("GET /health = %d %v", w.Code, body)
	}
}

func TestBadReleaseFailsHealthButStaysReady(t *testing.T) {
	h := New(config(t, "name: x\naccent: \"#112233\"\nsymbols: [USDJPY]\nrelease:\n  healthy: false\n"), web)
	if w := get(h, "/health"); w.Code != http.StatusServiceUnavailable {
		t.Fatalf("GET /health = %d, want 503", w.Code)
	}
	if w := get(h, "/ready"); w.Code != 200 {
		t.Fatalf("GET /ready = %d, want 200", w.Code)
	}
}

func TestQuotes(t *testing.T) {
	h := New(config(t, "name: x\naccent: \"#112233\"\nsymbols: [USDJPY, EURUSD]\n"), web)
	var quotes []map[string]any
	json.Unmarshal(get(h, "/api/quotes").Body.Bytes(), &quotes)
	if len(quotes) != 2 || quotes[0]["symbol"] != "USDJPY" {
		t.Fatalf("GET /api/quotes = %v", quotes)
	}
}

func TestStaticAndUnknownPaths(t *testing.T) {
	h := New(config(t, "name: x\naccent: \"#112233\"\nsymbols: [USDJPY]\n"), web)
	if w := get(h, "/static/shared.js"); w.Code != 200 {
		t.Fatalf("GET /static/shared.js = %d", w.Code)
	}
	if w := get(h, "/nope"); w.Code != 404 {
		t.Fatalf("GET /nope = %d, want 404", w.Code)
	}
}
