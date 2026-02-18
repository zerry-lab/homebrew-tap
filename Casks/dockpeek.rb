cask "dockpeek" do
  version "1.5.7"
  sha256 "48ccf4e600d69244cd5781621afd446b342b8c4a935a51013683791d88b442eb"

  url "https://github.com/ongjin/dockpeek/releases/download/v#{version}/DockPeek.zip"
  name "DockPeek"
  desc "Windows-style Dock window preview for macOS"
  homepage "https://github.com/ongjin/dockpeek"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on macos: ">= :sonoma"

  app "DockPeek.app"

  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/DockPeek.app"]
  end

  uninstall quit: "com.dockpeek.app"

  zap trash: [
    "~/Library/Preferences/com.dockpeek.app.plist",
  ]

  caveats <<~EOS
    FIRST LAUNCH (important — app is self-signed, not notarized):

    1. Open DockPeek — macOS will block it
    2. Go to: System Settings → Privacy & Security
    3. Scroll down to Security — click "Open Anyway" next to the DockPeek message
    4. Click "Open" in the confirmation dialog

    REQUIRED PERMISSIONS (grant after first launch):

    1. Accessibility — System Settings → Privacy & Security → Accessibility → Enable DockPeek
    2. Screen Recording — System Settings → Privacy & Security → Screen Recording → Enable DockPeek
  EOS
end
