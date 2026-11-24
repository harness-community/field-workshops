// Package brand loads and checks showcase.yaml, the file students edit to make the app theirs.
package brand

import (
	"fmt"
	"regexp"
	"strings"

	"gopkg.in/yaml.v3"
)

// Flavors are the apps one image can be. Add a flavor by adding web/<flavor>.html.
var Flavors = []string{"ticker", "billboard"}

const MaxSymbols = 8

type Config struct {
	Flavor  string   `yaml:"flavor" json:"flavor"`
	Version string   `yaml:"version" json:"version"`
	Name    string   `yaml:"name" json:"name"`
	Tagline string   `yaml:"tagline" json:"tagline"`
	Accent  string   `yaml:"accent" json:"accent"`
	Emoji   string   `yaml:"emoji" json:"emoji"`
	Message string   `yaml:"message" json:"message"`
	Symbols []string `yaml:"symbols" json:"symbols"`
	Release Release  `yaml:"release" json:"release"`
}

type Release struct {
	// A pointer, so a file that leaves it out gets a healthy release instead of a broken one
	Healthy *bool `yaml:"healthy" json:"healthy"`
}

func (c Config) Healthy() bool { return c.Release.Healthy == nil || *c.Release.Healthy }

var (
	hexColor = regexp.MustCompile(`^#[0-9A-Fa-f]{6}$`)
	semver   = regexp.MustCompile(`^\d+\.\d+\.\d+$`)
	symbol   = regexp.MustCompile(`^[A-Z0-9.]{1,10}$`)
)

// Parse reads showcase.yaml, fills in defaults, and rejects values the page can't show.
// Each error names the field and what to change, because a student reads it in a CI log.
func Parse(data []byte) (Config, error) {
	var c Config
	if err := yaml.Unmarshal(data, &c); err != nil {
		return c, fmt.Errorf("not valid YAML (check indentation and quotes): %w", err)
	}
	c.Flavor = strings.ToLower(strings.TrimSpace(c.Flavor))
	if c.Flavor == "" {
		c.Flavor = "ticker"
	}
	if c.Version == "" {
		c.Version = "1.0.0"
	}
	if c.Emoji == "" {
		c.Emoji = "🚀"
	}
	for i, s := range c.Symbols {
		c.Symbols[i] = strings.ToUpper(strings.TrimSpace(s))
	}
	return c, c.Validate()
}

func (c Config) Validate() error {
	var problems []string
	if !contains(Flavors, c.Flavor) {
		problems = append(problems, fmt.Sprintf("flavor %q must be one of %s", c.Flavor, strings.Join(Flavors, ", ")))
	}
	if !semver.MatchString(c.Version) {
		problems = append(problems, fmt.Sprintf("version %q must look like 1.2.3", c.Version))
	}
	if n := len([]rune(strings.TrimSpace(c.Name))); n == 0 || n > 40 {
		problems = append(problems, "name must be 1 to 40 characters")
	}
	if !hexColor.MatchString(c.Accent) {
		problems = append(problems, fmt.Sprintf("accent %q must be a hex color in quotes, like \"#00ADE4\"", c.Accent))
	}
	if len([]rune(c.Message)) > 140 {
		problems = append(problems, "message must be 140 characters or fewer")
	}
	if c.Flavor == "ticker" {
		if len(c.Symbols) == 0 || len(c.Symbols) > MaxSymbols {
			problems = append(problems, fmt.Sprintf("symbols needs 1 to %d entries for the ticker flavor", MaxSymbols))
		}
		for _, s := range c.Symbols {
			if !symbol.MatchString(s) {
				problems = append(problems, fmt.Sprintf("symbol %q must be 1 to 10 letters or digits", s))
			}
		}
	}
	if len(problems) > 0 {
		return fmt.Errorf("%s", strings.Join(problems, "; "))
	}
	return nil
}

func contains(list []string, s string) bool {
	for _, v := range list {
		if v == s {
			return true
		}
	}
	return false
}
