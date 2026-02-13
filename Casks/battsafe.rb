cask "battsafe" do
  version "1.7.2"
  sha256 "a183d3868b44931d259be74fb2afa475ada4dfe00ad60800fdf0d3a5896b3c6a"

  url "https://github.com/zerry-lab/battsafe-releases/releases/download/v1.7.2/BattSafe.zip"
  name "BattSafe"
  desc "Battery charge limit manager for Apple Silicon Macs"
  homepage "https://github.com/zerry-lab/battsafe-releases"

  depends_on macos: ">= :sonoma"
  depends_on arch: :arm64

  app "BattSafe.app"

  postflight do
    system_command "/bin/chmod",
                   args: ["+x", "#{appdir}/BattSafe.app/Contents/MacOS/BattSafeHelper"],
                   sudo: false
  end

  uninstall launchctl: "com.cyj.battsafe.helper",
            delete:    [
              "/Library/PrivilegedHelperTools/com.cyj.battsafe.helper",
              "/Library/LaunchDaemons/com.cyj.battsafe.helper.plist",
            ]

  zap trash: [
    "~/Library/Preferences/com.cyj.battsafe.plist",
    "~/Library/Caches/com.cyj.battsafe",
    "~/Library/Logs/com.cyj.battsafe",
  ]

  caveats <<~EOS
    BattSafe requires a privileged helper to control charging via SMC.
    On first launch, you will be prompted to install the helper tool.

    The helper requires root privileges to read/write SMC keys.
    You may need to grant accessibility permissions in:
      System Settings > Privacy & Security

    If macOS blocks the app (Gatekeeper), reinstall with:
      brew reinstall --cask --no-quarantine battsafe
  EOS
end
