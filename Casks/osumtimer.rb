cask "osumtimer" do
  version "1.0.0"
  sha256 "b0c13a479b9e9c93f89df0a9ce7bdf55561e2ce72ca3ad8ea66e69b8b9363ef0"

  url "https://github.com/vigneshmr/osumtimer/releases/download/v#{version}/OsumTimer-#{version}.dmg"
  name "OsumTimer"
  desc "Menu bar timer you drive by typing"
  homepage "https://github.com/vigneshmr/osumtimer"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "OsumTimer.app"

  # The bundle is ad-hoc signed, not notarized, so Gatekeeper would refuse a
  # quarantined copy outright. Stripping the flag is what the user would do by
  # hand anyway.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/OsumTimer.app"],
                   sudo: false
  end

  uninstall quit: "com.osumtimer.OsumTimer"

  zap trash: [
    "~/Library/Preferences/com.osumtimer.OsumTimer.plist",
    "~/Library/Application Support/OsumTimer",
  ]
end
