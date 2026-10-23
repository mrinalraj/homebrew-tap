cask "autopilot" do
  arch arm: "arm64", intel: "x64"

  version "0.1.0-beta.10"
  sha256 arm:   "9602294629bb006eb8dd5937fdc8d2acfbd91be79f3d95734d98242881520e02",
         intel: "02c882fd2cf986c11610a3b6be707e4a1138eb7dbe2420efdf70ee1635b9ccfa"

  url "https://github.com/mrinalraj/autopilot/releases/download/v#{version}/autopilot-#{version}-macos-#{arch}.zip"
  name "Autopilot"
  desc "Triage tracker tickets and launch Claude Code sessions"
  homepage "https://github.com/mrinalraj/autopilot"

  depends_on formula: "gh"
  depends_on macos: :ventura

  app "Autopilot.app"

  uninstall quit: "dev.autopilot.app"

  zap trash: [
    "~/Library/Logs/Autopilot",
    "~/Library/Preferences/dev.autopilot.app.plist",
    "~/Library/Saved Application State/dev.autopilot.app.savedState",
  ]

  caveats <<~EOS
    Open Autopilot from Applications to finish setup.
    If the formula service is running, the app connects to it and leaves it running on Quit.
    Otherwise the app starts its own worker, which stops on Quit.
    Enable Autopilot > Open at Login to start it when you sign in.
    Claude Code must be installed and logged in.

    macOS may block the first launch of an unnotarized beta. After trying to open it,
    use System Settings > Privacy & Security > Open Anyway and confirm.
    Signing status and instructions: https://github.com/mrinalraj/autopilot/releases/tag/v0.1.0-beta.10

    You can keep the formula installed and running. It supplies the autopilot CLI.
    Older formulas need an upgrade and service restart to support app connections:
      brew upgrade --formula autopilot
      brew services restart autopilot
    Uninstalling this app preserves shared settings, tickets and Keychain sign-in, even with --zap.
  EOS
end
