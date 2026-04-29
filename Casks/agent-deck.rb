cask "agent-deck" do
  version "0.1.0"
  sha256 "1ecf683a28ae4f2339088cb5a5cd93e92b8cb0977ca2a9f08812712777fa3052"

  url "https://github.com/zerry-lab/agent-deck-releases/releases/download/v#{version}/Agent_Deck_#{version}_aarch64.zip"
  name "Agent Deck"
  desc "Manage multiple Claude Code and Codex CLI accounts on macOS"
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
    "~/Library/LaunchAgents/com.cyj.agent-deck.rotate.plist",
    "~/.agent-deck",
  ]

  caveats <<~EOS
    Agent Deck is distributed without an Apple Developer ID signature, so
    macOS Gatekeeper may block the first launch. If it does, reinstall with:
      brew reinstall --cask --no-quarantine agent-deck
    or remove the quarantine attribute manually:
      xattr -dr com.apple.quarantine "/Applications/Agent Deck.app"

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
