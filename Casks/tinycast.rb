cask "tinycast" do
  version "0.11.19"
  sha256 "b8d0b19faa7971201fef8a7d79412172e6984dc03ad8121ecf952c3fe6f5c659"

  url "https://github.com/abue-ammar/tinycast/releases/download/v#{version}/Tinycast-#{version}.dmg"
  name "Tinycast"
  desc "Tiny, fully native launcher, hotkeys, and clipboard history"
  homepage "https://github.com/abue-ammar/tinycast"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  conflicts_with cask: [
    "abue-ammar/tinycast/tinycast",
    "abue-ammar/tinycast/tinycast-sequoia",
    "abue-ammar/tinycast/tinycast-universal",
  ]
  depends_on macos: :tahoe
  depends_on arch: :arm64

  app "Tinycast.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Tinycast.app"]
  end

  uninstall quit: "com.tinycast.app"

  zap login_item: "Tinycast",
      trash:      [
        "~/Library/Application Support/com.tinycast.app",
        "~/Library/Caches/com.tinycast.app",
        "~/Library/Preferences/com.tinycast.app.plist",
        "~/Library/Saved Application State/com.tinycast.app.savedState",
      ]
end
