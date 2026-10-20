class Autopilot < Formula
  desc "Triage Linear tickets and launch Claude Code sessions in worktrees"
  homepage "https://github.com/mrinalraj/autopilot"
  version "0.1.0-beta.7"

  on_arm do
    url "https://github.com/mrinalraj/autopilot/releases/download/v0.1.0-beta.7/autopilot-0.1.0-beta.7-darwin-arm64.tar.gz"
    sha256 "590e22f61ab91efc0241af981e516205e9067ab1941ce1f11e71e16bca4fc362"
  end
  on_intel do
    url "https://github.com/mrinalraj/autopilot/releases/download/v0.1.0-beta.7/autopilot-0.1.0-beta.7-darwin-x64.tar.gz"
    sha256 "d75247531c3ebd0dfd3b3b6d3cc297c8b6b2bf44f694621807e3ec93d7a873cb"
  end

  depends_on :macos
  depends_on "terminal-notifier"
  depends_on "gh" => :recommended

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
