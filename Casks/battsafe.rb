cask "battsafe" do
  version "1.0.0"
  sha256 "16d043278d834cb4f219569eb93aac2574977c99a7d292e344db835b6ab9a630"

  url "https://github.com/zerry-lab/battsafe-releases/releases/download/v1.0.0/BattSafe.zip"
  name "BattSafe"
  desc "Battery charge limit manager for Apple Silicon Macs"
  homepage "https://github.com/zerry-lab/battsafe-releases"

  depends_on macos: ">= :sonoma"

  app "BattSafe.app"

  zap trash: [
    "~/Library/Preferences/com.cyj.battsafe.plist",
    "/Library/PrivilegedHelperTools/com.cyj.battsafe.helper",
    "/Library/LaunchDaemons/com.cyj.battsafe.helper.plist",
  ]
end
