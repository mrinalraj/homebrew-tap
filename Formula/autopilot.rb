class Autopilot < Formula
  desc "Triage Linear tickets and launch Claude Code sessions in worktrees"
  homepage "https://github.com/mrinalraj/autopilot"
  version "0.1.0-beta.10"

  on_arm do
    url "https://github.com/mrinalraj/autopilot/releases/download/v0.1.0-beta.10/autopilot-0.1.0-beta.10-darwin-arm64.tar.gz"
    sha256 "6ed4c745b35b4194632f5cbf6dccf8894005f06877b7c1426c19f2cb0d11cb87"
  end
  on_intel do
    url "https://github.com/mrinalraj/autopilot/releases/download/v0.1.0-beta.10/autopilot-0.1.0-beta.10-darwin-x64.tar.gz"
    sha256 "bb2c6af147dc0e635d3125b7d7f0099cd7c53c4539481dd5c00bd7b6abd78847"
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
