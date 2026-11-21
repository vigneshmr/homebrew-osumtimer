cask "osumtimer" do
  version "1.2.0"
  sha256 "669de4747603228aa86d1e70f88be0690204bfbbfba4124e3217537e99aa8d17"

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
