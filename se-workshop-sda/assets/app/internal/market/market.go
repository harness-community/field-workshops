// Package market simulates a live quote board for the ticker flavor. Prices are a pure
// function of the symbol and the clock, so every pod answers with the same number and the
// board doesn't jump when the load balancer switches pods mid-canary.
package market

import (
	"hash/fnv"
	"math"
	"strconv"
	"strings"
	"time"
)

// Opening prices for symbols people usually pick. Anything else gets a stable made-up price.
var opens = map[string]float64{
	"USDJPY": 151.42, "EURUSD": 1.0842, "GBPUSD": 1.2671, "AUDUSD": 0.6589, "USDCHF": 0.8812,
	"USDCAD": 1.3604, "EURJPY": 164.17, "GBPJPY": 191.86, "BTCUSD": 64250.10, "ETHUSD": 3120.55,
}

type Quote struct {
	Symbol    string  `json:"symbol"`
	Price     float64 `json:"price"`
	Display   string  `json:"display"`
	Change    float64 `json:"change"`
	ChangePct float64 `json:"changePct"`
}

// Decimals is how many decimal places a symbol is quoted to on a trading desk: yen pairs
// to 2 (151.42), crypto to 2 (64250.10), and every other FX pair to 4 (1.0842).
func Decimals(symbol string) int {
	s := strings.ToUpper(symbol)
	switch {
	case strings.HasPrefix(s, "JPY"):
		return 2
	case strings.HasPrefix(s, "BTC"), strings.HasPrefix(s, "ETH"):
		return 2
	case len(s) == 6:
		return 4
	default:
		return 2
	}
}

// FormatPrice renders a price the way the board shows it, rounded to the symbol's decimals.
func FormatPrice(symbol string, price float64) string {
	return strconv.FormatFloat(price, 'f', Decimals(symbol), 64)
}

func Open(symbol string) float64 {
	if p, ok := opens[strings.ToUpper(symbol)]; ok {
		return p
	}
	h := fnv.New32a()
	h.Write([]byte(symbol))
	return 20 + float64(h.Sum32()%48000)/100 // 20.00 to 499.99
}

// At returns the quote for a symbol at a moment in time. A few slow waves make it drift
// like a market without needing any state or a data feed.
func At(symbol string, t time.Time) Quote {
	open := Open(symbol)
	h := fnv.New32a()
	h.Write([]byte(symbol))
	phase := float64(h.Sum32()%628) / 100
	s := float64(t.UnixMilli()) / 1000
	drift := 0.0040*math.Sin(2*math.Pi*s/97+phase) +
		0.0018*math.Sin(2*math.Pi*s/23+2*phase) +
		0.0006*math.Sin(2*math.Pi*s/5+3*phase)
	price := open * (1 + drift)
	return Quote{
		Symbol:    symbol,
		Price:     price,
		Display:   FormatPrice(symbol, price),
		Change:    price - open,
		ChangePct: drift * 100,
	}
}

func Board(symbols []string, t time.Time) []Quote {
	quotes := make([]Quote, 0, len(symbols))
	for _, s := range symbols {
		quotes = append(quotes, At(s, t))
	}
	return quotes
}
