cask "tokeneater" do
  version "6.0.0"
  sha256 "298bbe94beef793fb96bdc531ed3924fa43363c7c06e72d578bd00ab5da3f7dc"

  url "https://github.com/AThevon/TokenEater/releases/download/v#{version}/TokenEater.dmg"
  name "TokenEater"
  desc "Menu bar monitor for Claude AI usage limits"
  homepage "https://github.com/AThevon/TokenEater"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  auto_updates true
  conflicts_with cask: "athevon/tokeneater/tokeneater"
  depends_on macos: :sonoma

  app "TokenEater.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/TokenEater.app"]
  end

  uninstall quit: "com.tokeneater.app"

  zap login_item: "TokenEater",
      trash:      [
        "~/Library/Application Support/com.claudeusagewidget.shared",
        "~/Library/Application Support/com.tokeneater.shared",
        "~/Library/Containers/com.claudeusagewidget.app",
        "~/Library/Containers/com.claudeusagewidget.app.widget",
        "~/Library/Containers/com.claudeusagewidget.widget",
        "~/Library/Containers/com.tokeneater.app",
        "~/Library/Containers/com.tokeneater.app.widget",
        "~/Library/Group Containers/S7B8M9JYF4.group.com.tokeneater",
        "~/Library/Preferences/com.tokeneater.app.plist",
        "~/Library/Preferences/com.tokeneater.app.widget.plist",
      ]
end
