package brand

import (
	"os"
	"strings"
	"testing"
)

// The file students edit has to pass the same checks the server applies at startup
func TestShowcaseYAMLIsValid(t *testing.T) {
	data, err := os.ReadFile("../../showcase.yaml")
	if err != nil {
		t.Fatal(err)
	}
	if _, err := Parse(data); err != nil {
		t.Fatalf("showcase.yaml has a problem: %v", err)
	}
}

func TestDefaults(t *testing.T) {
	c, err := Parse([]byte("name: Desk\naccent: \"#112233\"\nsymbols: [usdjpy]\n"))
	if err != nil {
		t.Fatal(err)
	}
	if c.Flavor != "ticker" || c.Version != "1.0.0" || !c.Healthy() || c.Symbols[0] != "USDJPY" {
		t.Fatalf("unexpected defaults: %+v", c)
	}
}

func TestRejectsBadValues(t *testing.T) {
	cases := map[string]string{
		"flavor":  "flavor: weather\nname: x\naccent: \"#112233\"\n",
		"accent":  "flavor: billboard\nname: x\naccent: red\n",
		"version": "flavor: billboard\nname: x\naccent: \"#112233\"\nversion: two\n",
		"symbols": "flavor: ticker\nname: x\naccent: \"#112233\"\nsymbols: []\n",
	}
	for field, doc := range cases {
		if _, err := Parse([]byte(doc)); err == nil || !strings.Contains(err.Error(), field) {
			t.Errorf("%s: expected an error naming the field, got %v", field, err)
		}
	}
}

func TestUnhealthyRelease(t *testing.T) {
	c, err := Parse([]byte("flavor: billboard\nname: x\naccent: \"#112233\"\nrelease:\n  healthy: false\n"))
	if err != nil {
		t.Fatal(err)
	}
	if c.Healthy() {
		t.Fatal("release.healthy: false should make the release unhealthy")
	}
}

func TestEmojiNames(t *testing.T) {
	base := "flavor: billboard\nname: x\naccent: \"#112233\"\nemoji: "
	for in, want := range map[string]string{
		"rocket": "🚀", `":tada:"`: "🎉", "Fire": "🔥", "thumbsup": "👍", "100": "💯", "fox-face": "🦊", `"🦄"`: "🦄", `""`: "🚀",
	} {
		c, err := Parse([]byte(base + in + "\n"))
		if err != nil || c.Emoji != want {
			t.Errorf("emoji %s: got %q, %v; want %q", in, c.Emoji, err, want)
		}
	}
	if _, err := Parse([]byte(base + "fishy\n")); err == nil || !strings.Contains(err.Error(), "emoji") {
		t.Errorf("an unknown emoji name should be an error naming the field, got %v", err)
	}
}
