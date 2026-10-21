class Autopilot < Formula
  desc "Triage Linear tickets and launch Claude Code sessions in worktrees"
  homepage "https://github.com/mrinalraj/autopilot"
  version "0.1.0-beta.8"

  on_arm do
    url "https://github.com/mrinalraj/autopilot/releases/download/v0.1.0-beta.8/autopilot-0.1.0-beta.8-darwin-arm64.tar.gz"
    sha256 "235fad6e898f0394ac8c038d3f78c884c4b3072d10b45eebebfc2e214a3d2698"
  end
  on_intel do
    url "https://github.com/mrinalraj/autopilot/releases/download/v0.1.0-beta.8/autopilot-0.1.0-beta.8-darwin-x64.tar.gz"
    sha256 "606339eed95bd556d0df980dd8e1038e8aaa9bdd000c9b1fe3f91e44d0fcac37"
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
