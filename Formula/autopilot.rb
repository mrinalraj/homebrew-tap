class Autopilot < Formula
  desc "Triage Linear tickets and launch Claude Code sessions in worktrees"
  homepage "https://github.com/mrinalraj/autopilot"
  version "0.1.0-beta.9"

  on_arm do
    url "https://github.com/mrinalraj/autopilot/releases/download/v0.1.0-beta.9/autopilot-0.1.0-beta.9-darwin-arm64.tar.gz"
    sha256 "1d2116b07d580da4eb57e383fc803b9b04fcb3e9e14e2aafeca043989d6836ac"
  end
  on_intel do
    url "https://github.com/mrinalraj/autopilot/releases/download/v0.1.0-beta.9/autopilot-0.1.0-beta.9-darwin-x64.tar.gz"
    sha256 "ffb69aa12e0e12ad0697a75dae5edc7552c0bfe8132cf17361fa38483da704f5"
  end

  depends_on :macos
  depends_on "terminal-notifier"
  depends_on "gh"

  def install
    bin.install "autopilot"
  end

  service do
    run [opt_bin/"autopilot", "start"]
    keep_alive true
    process_type :background
    log_path var/"log/autopilot.log"
    error_log_path var/"log/autopilot.log"
  end

  def caveats
    <<~EOS
      Needs Claude Code (the `claude` CLI, logged in) and, for the default launcher, Supacode.
      Other launchers (Worktrunk, git, VS Code, Cursor) can be picked in Settings.

      First run:
        autopilot login              # once, in the browser
        brew services start autopilot
        open http://localhost:4747
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/autopilot version").strip
  end
end
