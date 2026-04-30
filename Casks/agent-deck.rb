cask "agent-deck" do
  version "0.3.2"
  sha256 "013db244e42b979931bf888d2873d7e2d575955b5f3f616a2b82a18e179219ee"

  url "https://github.com/zerry-lab/agent-deck-releases/releases/download/v#{version}/Agent_Deck_#{version}_aarch64.zip"
  name "Agent Deck"
  desc "Manage multiple Claude Code and Codex CLI accounts"
  homepage "https://github.com/zerry-lab/agent-deck-releases"

  depends_on macos: ">= :sonoma"
  depends_on arch: :arm64

  app "Agent Deck.app"

  uninstall launchctl: "com.cyj.agent-deck.rotate",
            delete:    [
              "/opt/homebrew/bin/ad",
              "/usr/local/bin/ad",
            ]

  zap trash: [
    "~/.agent-deck",
    "~/Library/LaunchAgents/com.cyj.agent-deck.rotate.plist",
  ]

  caveats <<~EOS
    Agent Deck is distributed without an Apple Developer ID signature, so
    macOS Gatekeeper may block the first launch. If it does, remove the
    quarantine attribute:
      xattr -dr com.apple.quarantine "/Applications/Agent Deck.app"
    or reinstall while bypassing quarantine:
      HOMEBREW_CASK_OPTS=--no-quarantine brew reinstall --cask agent-deck

    To use the `ad` CLI from any terminal, open Agent Deck → Settings → CLI
    and click "Install CLI to PATH" (it creates a symlink at
    /opt/homebrew/bin/ad pointing into the .app).

    The auto-rotation daemon runs as a per-user LaunchAgent
    (com.cyj.agent-deck.rotate) every 60s. It is installed/uninstalled from
    Settings → Daemon — Drag-to-Trash uninstall does NOT remove it, so
    prefer `brew uninstall --cask agent-deck` (or the in-app button) for a
    clean removal. `brew uninstall --cask --zap agent-deck` also wipes the
    vault at ~/.agent-deck.
  EOS
end
