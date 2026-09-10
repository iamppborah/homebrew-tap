cask "tinycast" do
  version "0.10.15"
  sha256 "25e005c1d3078863f60caa67edd7a999ed3c603ffcf76ec6d240a8d6d88014a9"

  url "https://github.com/abue-ammar/tinycast/releases/download/v#{version}/Tinycast-#{version}.dmg"
  name "Tinycast"
  desc "Tiny, fully native launcher, hotkeys, and clipboard history"
  homepage "https://abue-ammar.github.io/tinycast/"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  # Same app name and bundle id as the casks in abue-ammar/tinycast, so no two can coexist.
  conflicts_with cask: [
    "abue-ammar/tinycast/tinycast",
    "abue-ammar/tinycast/tinycast-sequoia",
    "abue-ammar/tinycast/tinycast-universal",
  ]
  # `:tahoe` already means ">= macOS 26"; the DMG is arm64-only. Intel or macOS 15
  # Macs take tinycast-universal / tinycast-sequoia from abue-ammar/tinycast instead.
  depends_on arch: :arm64
  depends_on macos: :tahoe

  app "Tinycast.app"

  # Detect whether this run is a fresh install or an upgrade. preflight runs before the
  # new bundle is staged into place, so if an app is already in appdir it's an upgrade.
  # Steps can't hand state to the postflight plan directly, so drop a marker in staged_path.
  preflight_steps do
    if_path_exists "Tinycast.app", base: :appdir do
      touch ".upgrade"
    end
  end

  # Tinycast is signed with a stable self-signed identity (not an Apple Developer ID / not
  # notarized), so macOS quarantines it. Strip the flag on every install AND upgrade so
  # Gatekeeper won't block launch — the user never has to run xattr by hand. Only relaunch
  # on an upgrade, to restore the copy `uninstall quit:` had to close; a fresh install is
  # left for the user to open. `open -g` starts it in the background, so nothing steals focus.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Tinycast.app"]

    # The marker outlives this guard: `if_path_exists` is evaluated when it is reached,
    # so the removal below must stay last.
    if_path_exists ".upgrade" do
      run "/usr/bin/open", args: ["-g", "{{appdir}}/Tinycast.app"]
    end

    remove ".upgrade"
  end

  # Quit the running app before Homebrew replaces the bundle on upgrade/uninstall — otherwise
  # the update clobbers a live process. postflight_steps relaunches it after an upgrade; a
  # plain uninstall runs no postflight, so the app stays closed.
  uninstall quit: "com.tinycast.app"

  zap login_item: "Tinycast",
      trash:      [
        "~/Library/Application Support/com.tinycast.app",
        "~/Library/Caches/com.tinycast.app",
        "~/Library/Preferences/com.tinycast.app.plist",
        "~/Library/Saved Application State/com.tinycast.app.savedState",
      ]
end
