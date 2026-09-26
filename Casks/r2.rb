cask "r2" do
  version "0.3.8"
  sha256 "558d45aa737e636c8398b8343c07bcee38a602227b0ddd9b239174873ad9f43b"

  url "https://github.com/dickwu/r2/releases/download/v#{version}/r2_#{version}_aarch64.dmg"
  name "R2 Client"
  desc "Free open-source Cloudflare R2 desktop client and S3 GUI"
  homepage "https://r2.lifefarmer.ca"

  livecheck do
    url :url
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  depends_on arch: :arm64
  depends_on :macos

  app "r2.app"

  postflight_steps do
    run "/usr/bin/xattr", args: ["-d", "-r", "com.apple.quarantine", "{{appdir}}/r2.app"]
  end

  zap trash: [
    "~/Library/Application Support/com.lifefarmer.r2",
    "~/Library/Caches/com.lifefarmer.r2",
    "~/Library/Preferences/com.lifefarmer.r2.plist",
    "~/Library/Saved Application State/com.lifefarmer.r2.savedState",
  ]
end
