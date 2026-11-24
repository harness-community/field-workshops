package market

import (
	"testing"
	"time"
)

func TestFormatPrice(t *testing.T) {
	cases := []struct {
		symbol string
		price  float64
		want   string
	}{
		{"EURUSD", 1.08423, "1.0842"},
		{"GBPUSD", 1.26719, "1.2672"},
		{"USDJPY", 151.4167, "151.42"},
		{"EURJPY", 164.1749, "164.17"},
		{"BTCUSD", 64250.104, "64250.10"},
		{"ACME", 12.3456, "12.35"},
	}
	for _, c := range cases {
		if got := FormatPrice(c.symbol, c.price); got != c.want {
			t.Errorf("FormatPrice(%q, %v) = %q, want %q", c.symbol, c.price, got, c.want)
		}
	}
}

// Every pod must agree on the price at a given moment, or the board flickers during a canary
func TestPodsAgree(t *testing.T) {
	now := time.Unix(1765000000, 0)
	if At("USDJPY", now) != At("USDJPY", now) {
		t.Fatal("same symbol and time gave different quotes")
	}
}

func TestStaysNearOpen(t *testing.T) {
	start := time.Unix(1765000000, 0)
	for i := 0; i < 600; i++ {
		q := At("EURUSD", start.Add(time.Duration(i)*time.Second))
		if q.ChangePct > 1 || q.ChangePct < -1 {
			t.Fatalf("price drifted %.2f%% from open", q.ChangePct)
		}
	}
}
