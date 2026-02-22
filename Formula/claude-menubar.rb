class ClaudeMenubar < Formula
  desc "SwiftBar plugin that shows Claude Code session status in the macOS menubar"
  homepage "https://github.com/emreboga/claude-menubar"
  url "https://github.com/emreboga/claude-menubar/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "bd50bde8136a0748aaaf597d3deb9a320110db83fd1d6ed8d240a63d6c4e84c1"
  license "MIT"
  version "1.0.0"

  head "https://github.com/emreboga/claude-menubar.git", branch: "main"

  depends_on :macos

  def install
    # Install source to pkgshare for reference and future upgrades
    pkgshare.install "scripts", "lib", "config", "setup.sh", "uninstall.sh"
    chmod 0755, pkgshare/"setup.sh"
    chmod 0755, pkgshare/"uninstall.sh"

    # Create wrapper scripts in bin
    (bin/"claude-menubar-setup").write <<~EOS
      #!/bin/bash
      exec "#{pkgshare}/setup.sh" "$@"
    EOS

    (bin/"claude-menubar-uninstall").write <<~EOS
      #!/bin/bash
      exec "#{pkgshare}/uninstall.sh" "$@"
    EOS

    chmod 0755, bin/"claude-menubar-setup"
    chmod 0755, bin/"claude-menubar-uninstall"
  end

  def caveats
    <<~EOS
      To complete installation, run:
        claude-menubar-setup

      This sets up ~/.claude-menubar and configures Claude Code hooks.

      Optionally specify your terminal (default is auto-detected):
        claude-menubar-setup --terminal Warp

      Supported terminals: Terminal, iTerm, iTerm2, Warp,
                           Alacritty, kitty, Hyper, WezTerm, Ghostty

      Requires SwiftBar:
        brew install --cask swiftbar

      To uninstall:
        claude-menubar-uninstall
        brew uninstall claude-menubar
    EOS
  end

  test do
    assert_predicate pkgshare/"setup.sh", :exist?
    assert_predicate pkgshare/"scripts/cc-status", :exist?
    assert_predicate pkgshare/"scripts/claude-menubar.10s.sh", :exist?
    assert_predicate pkgshare/"scripts/clear-all", :exist?
    assert_predicate pkgshare/"scripts/focus-terminal", :exist?
    assert_predicate pkgshare/"lib/common.sh", :exist?
    assert_predicate pkgshare/"config/claude-hooks.json", :exist?
    assert_predicate bin/"claude-menubar-setup", :exist?
    assert_predicate bin/"claude-menubar-uninstall", :exist?
  end
end
