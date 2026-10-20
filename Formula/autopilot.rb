class Autopilot < Formula
  desc "Triage Linear tickets and launch Claude Code sessions in worktrees"
  homepage "https://github.com/mrinalraj/autopilot"
  version "0.1.0-beta.6"

  on_arm do
    url "https://github.com/mrinalraj/autopilot/releases/download/v0.1.0-beta.6/autopilot-0.1.0-beta.6-darwin-arm64.tar.gz"
    sha256 "0eee631553e7680f63ccb04bde22d4a8e261200c23687de6b08c0d6520da3a5d"
  end
  on_intel do
    url "https://github.com/mrinalraj/autopilot/releases/download/v0.1.0-beta.6/autopilot-0.1.0-beta.6-darwin-x64.tar.gz"
    sha256 "00094cf72c06ffb16840da08e5926492b0a24664de40ef7c46f922af24605a91"
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
