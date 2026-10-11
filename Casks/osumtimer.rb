cask "osumtimer" do
  version "1.1.1"
  sha256 "b74beaa9d60413cf90d4d327e6e3cd0a20cf6ab115e6613e9ca32a3ca1290dc1"

  url "https://github.com/vigneshmr/osumtimer/releases/download/v#{version}/OsumTimer-#{version}.dmg"
  name "OsumTimer"
  desc "Menu bar timer you drive by typing"
  homepage "https://github.com/vigneshmr/osumtimer"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: :sonoma

  app "OsumTimer.app"

  # The bundle is ad-hoc signed, not notarized, so Gatekeeper would refuse a
  # quarantined copy outright. Stripping the flag is what the user would do by
  # hand anyway.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/OsumTimer.app"]
  end

  uninstall quit: "com.osumtimer.OsumTimer"

  zap trash: [
    "~/Library/Preferences/com.osumtimer.OsumTimer.plist",
    "~/Library/Application Support/OsumTimer",
  ]
end
