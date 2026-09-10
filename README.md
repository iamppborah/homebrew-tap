# homebrew-tap

A personal [Homebrew](https://brew.sh) tap. It holds casks for macOS apps that
are not in `homebrew-cask` — usually because they were removed from it, or were
never accepted in the first place.

Each cask is pinned to a `sha256`, and a weekly GitHub Action bumps the version
and hash when upstream publishes a release.

## Install

```sh
brew install --cask iamppborah/tap/<cask>
```

That taps automatically. Use the full name, not just `<cask>` — if
`homebrew-cask` has a cask of the same name, the short form gets **theirs**,
not this one. For `pomotroid` that is the disabled cask, which refuses to
install.

## Casks

| Cask | Upstream | Description |
| --- | --- | --- |
| `pomotroid` | [Splode/pomotroid](https://github.com/Splode/pomotroid) | Simple and visually-pleasing Pomodoro timer |
| `r2` | [dickwu/r2](https://github.com/dickwu/r2) | Free open-source Cloudflare R2 desktop client and S3 GUI |
| `tinycast` | [abue-ammar/tinycast](https://github.com/abue-ammar/tinycast) | Tiny, fully native launcher, hotkeys, and clipboard history |

## Security

Casks here may strip `com.apple.quarantine`, which **skips** Apple's malware
check rather than passing it.

macOS tags anything downloaded with a hidden `com.apple.quarantine` flag, and
Gatekeeper only inspects files that carry it. A cask that deletes the flag after
install leaves the app looking as if it had always been local, so the check
never runs.

That means trusting the upstream project instead of Apple. The pinned `sha256`
fixes which bytes you get, not what they do. If you would rather keep Gatekeeper
involved, don't use these casks — download from upstream and click through
**Open Anyway** yourself.

## Uninstall

```sh
brew uninstall --cask <cask>          # remove the app
brew uninstall --cask --zap <cask>    # also the cask's zap paths
brew untap iamppborah/tap             # remove the tap
```

## Licence

[MIT](LICENSE) — these casks describe how to install upstream software, they do
not redistribute it. Each project keeps its own licence.
