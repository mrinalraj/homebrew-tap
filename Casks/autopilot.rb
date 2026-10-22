cask "autopilot" do
  arch arm: "arm64", intel: "x64"

  version "0.1.0-beta.9"
  sha256 arm:   "5f314b2b822d2e57e6ef7eecdd285bfcf967ecd4df3eb5d4596929ad59b8bd92",
         intel: "3b00b5c28031f79798eabebc3fb3c139d3e9ef595098c6762d9f518437059ade"

  url "https://github.com/mrinalraj/autopilot/releases/download/v#{version}/autopilot-#{version}-macos-#{arch}.zip"
  name "Autopilot"
  desc "Triage tracker tickets and launch Claude Code sessions"
  homepage "https://github.com/mrinalraj/autopilot"

  depends_on formula: "gh"
  depends_on macos: :ventura

  app "Autopilot.app"
  binary "#{appdir}/Autopilot.app/Contents/Helpers/autopilot"

  uninstall quit: "dev.autopilot.app"

  zap trash: [
    "~/Library/Application Support/autopilot",
    "~/Library/Logs/Autopilot",
    "~/Library/Preferences/dev.autopilot.app.plist",
    "~/Library/Saved Application State/dev.autopilot.app.savedState",
  ]

  caveats <<~EOS
    Open Autopilot from Applications to finish setup. It manages its own worker.
    Enable Autopilot > Open at Login to start it when you sign in.
    Claude Code must be installed and logged in.

    macOS may block the first launch of an unnotarized beta. After trying to open it,
    use System Settings > Privacy & Security > Open Anyway and confirm.
    Signing status and instructions: https://github.com/mrinalraj/autopilot/releases/tag/v0.1.0-beta.9

    Migrating from the formula: stop its service and uninstall the formula first:
      brew services stop autopilot
      brew uninstall --formula autopilot
    Your settings, tickets and Keychain sign-in are preserved.
  EOS
end
