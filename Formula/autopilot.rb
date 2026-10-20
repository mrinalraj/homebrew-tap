class Autopilot < Formula
  desc "Triage Linear tickets and launch Claude Code sessions in worktrees"
  homepage "https://github.com/mrinalraj/autopilot"
  version "0.1.0-beta.5"

  on_arm do
    url "https://github.com/mrinalraj/autopilot/releases/download/v0.1.0-beta.5/autopilot-0.1.0-beta.5-darwin-arm64.tar.gz"
    sha256 "171ab62e23e93d95b9d2e0e7ff077e16d388dd9de1490c9187b01f9f91413be2"
  end
  on_intel do
    url "https://github.com/mrinalraj/autopilot/releases/download/v0.1.0-beta.5/autopilot-0.1.0-beta.5-darwin-x64.tar.gz"
    sha256 "7aba4bd4e0844d6ddf320bca3f268946922342a4d0a432ba4bd92b4d9cfc30dd"
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
