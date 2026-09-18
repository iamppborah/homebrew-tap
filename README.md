# homebrew-tap

A personal [Homebrew](https://brew.sh) tap. It holds casks for macOS apps that
are not in `homebrew-cask`.

Each cask is pinned to a `sha256`. When upstream publishes a release, a weekly
GitHub Action opens a pull request with the new version and hash — nothing here
changes until it is merged.

## Security

Every cask here strips `com.apple.quarantine` in a `postflight_steps` stanza.
macOS tags anything downloaded with that flag and Gatekeeper only checks files
that carry it, so deleting it means the check never runs.

Most of these apps are ad-hoc or self-signed, so Gatekeeper's answer is a flat
no. The point of stripping the flag is that the app opens on the first try — no
"damaged, move to Bin", no **Open Anyway** button to go hunting for, because
there isn't one.

The cost is trusting the upstream project instead of Apple; the pinned `sha256`
fixes which bytes you get, not what they do.

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
| `tinycast` | [abue-ammar/tinycast](https://github.com/abue-ammar/tinycast) | Tiny, fully native macOS launcher, hotkeys, and clipboard history. |
| `tokeneater` | [AThevon/TokenEater](https://github.com/AThevon/TokenEater) | macOS menu bar monitor for Claude AI usage limits |

## Uninstall

```sh
brew uninstall --cask <cask>          # remove the app
brew uninstall --cask --zap <cask>    # also the cask's zap paths
brew untap iamppborah/tap             # remove the tap
```

## Licence

[MIT](LICENSE) — these casks describe how to install upstream software, they do
not redistribute it. Each project keeps its own licence.
