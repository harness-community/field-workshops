package brand

import (
	_ "embed"
	"encoding/json"
	"fmt"
	"regexp"
	"strings"
)

// emoji.json maps standard emoji names (GitHub's full gemoji set, like rocket or tada) to the
// emoji itself, because the browser editor students use can't type emoji. The Lab 1 Check in
// sda_checks.py reads the same file. It's built from github/gemoji db/emoji.json (MIT, see
// emoji.LICENSE), minus +1, -1 and on, which YAML parsers read as numbers or true. Use
// thumbsup or thumbsdown instead of +1 or -1.
//
//go:embed emoji.json
var emojiJSON []byte

var emojiNames = func() map[string]string {
	m := map[string]string{}
	if err := json.Unmarshal(emojiJSON, &m); err != nil {
		panic(err)
	}
	return m
}()

// A name is plain ASCII, optionally wrapped in colons: rocket, :tada:, 100
var emojiName = regexp.MustCompile(`^:?([a-z0-9_+-]+):?$`)

// resolveEmoji turns a name into its emoji. Anything that isn't a name, such as a pasted
// emoji, passes through unchanged.
func resolveEmoji(s string) (string, error) {
	s = strings.TrimSpace(s)
	m := emojiName.FindStringSubmatch(strings.ToLower(s))
	if m == nil {
		return s, nil
	}
	name := strings.ReplaceAll(m[1], "-", "_")
	if e, ok := emojiNames[name]; ok {
		return e, nil
	}
	return s, fmt.Errorf("emoji %q isn't a name this app knows. Try rocket, fire, tada, chart, "+
		"moneybag or robot, or see internal/brand/emoji.json for all of them", s)
}
