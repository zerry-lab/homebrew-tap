cask "agent-deck" do
  version "0.4.10"
  sha256 "e32fcec6f1385842c81a68da59612f7449e20f8fed7d2aaf994702528a75c43f"

  url "https://github.com/zerry-lab/agent-deck-releases/releases/download/v#{version}/Agent_Deck_#{version}_aarch64.zip"
  name "Agent Deck"
  desc "Manage multiple Claude Code and Codex CLI accounts"
  homepage "https://github.com/zerry-lab/agent-deck-releases"

  depends_on macos: :sonoma
  depends_on arch: :arm64

  app "Agent Deck.app"

  uninstall launchctl: [
              "com.cyj.agent-deck.login",
              "com.cyj.agent-deck.rotate",
            ],
            delete:    [
              "/opt/homebrew/bin/ad",
              "/usr/local/bin/ad",
            ]

  zap trash: [
    "~/.agent-deck",
    "~/Library/LaunchAgents/com.cyj.agent-deck.login.plist",
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

    Agent Deck can also install per-user LaunchAgents for login startup
    (com.cyj.agent-deck.login) and auto-rotation (com.cyj.agent-deck.rotate).
    These are managed from Settings. Drag-to-Trash uninstall does NOT remove
    them, so prefer `brew uninstall --cask agent-deck` for a clean removal.
    `brew uninstall --cask --zap agent-deck` also wipes the vault at
    ~/.agent-deck.
  EOS
end
