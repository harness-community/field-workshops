# sda-showcase

The app you ship in the Harness Software Delivery Agent workshop. It comes in two flavors:

- **ticker**: a live trading-floor board with FX and crypto quotes, desk clocks and a scrolling tape
- **billboard**: an LED marquee that scrolls your team's message

## Make it yours

Everything you can change is in **`showcase.yaml`**: the flavor, name, colors, emoji, message
and ticker symbols. It's compiled into the app, so a change only goes live once your pipeline
builds and deploys it.

Bump `version` every time you ship. The page announces each new release, and the strip at the
bottom shows which pods are serving which version, so you can watch a canary roll out.

## What's in here

| Path | What it is |
|------|------------|
| `showcase.yaml` | Your settings |
| `main.go`, `internal/` | The Go web server, with unit tests next to each package |
| `web/` | The two flavors' pages (no external scripts, fonts or APIs) |
| `Dockerfile` | Builds a ~10 MB image that runs as non-root |
| `deploy/` | Kubernetes manifests and values that Harness deploys |

## Endpoints

| Path | Returns |
|------|---------|
| `/` | The page for your flavor |
| `/version` | The version, flavor, environment and pod name |
| `/health` | `200` for a healthy release, `503` when `release.healthy` is `false` |
| `/ready` | Always `200` once the server is up (used by Kubernetes probes) |

## Run it locally (optional)

```bash
go test ./...
go run .            # http://localhost:8080
```
