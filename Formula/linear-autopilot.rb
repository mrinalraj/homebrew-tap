class LinearAutopilot < Formula
  desc "Triage Linear tickets and launch Claude Code sessions in worktrees"
  homepage "https://github.com/mrinalraj/linear-autopilot"
  version "0.1.0-beta.3"

  on_arm do
    url "https://github.com/mrinalraj/linear-autopilot/releases/download/v0.1.0-beta.3/linear-autopilot-0.1.0-beta.3-darwin-arm64.tar.gz"
    sha256 "6121af8dc56d470d7ef4f850a705bfc2dee71e419f0e7d53b7fe1ca34d5c474e"
  end
  on_intel do
    url "https://github.com/mrinalraj/linear-autopilot/releases/download/v0.1.0-beta.3/linear-autopilot-0.1.0-beta.3-darwin-x64.tar.gz"
    sha256 "a924fd764155e8b336fc372c9ae8ccc85f1113e6f3bfb1627b0018b4251cd838"
  end

  depends_on :macos
  depends_on "terminal-notifier"
  depends_on "gh" => :recommended

  def install
    bin.install "linear-autopilot"
  end

  service do
    run [opt_bin/"linear-autopilot", "start"]
    keep_alive true
    process_type :background
    log_path var/"log/linear-autopilot.log"
    error_log_path var/"log/linear-autopilot.log"
  end

  def caveats
    <<~EOS
      Needs Claude Code (the `claude` CLI, logged in) and, for the default launcher, Supacode.
      Other launchers (Worktrunk, git, VS Code, Cursor) can be picked in Settings.

      First run:
        linear-autopilot login              # once, in the browser
        brew services start linear-autopilot
        open http://localhost:4747
    EOS
  end

  test do
    assert_equal version.to_s, shell_output("#{bin}/linear-autopilot version").strip
  end
end
