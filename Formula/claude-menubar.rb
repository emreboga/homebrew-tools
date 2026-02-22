class ClaudeMenubar < Formula
  desc "SwiftBar plugin that shows Claude Code session status in the macOS menubar"
  homepage "https://github.com/emreboga/claude-menubar"
  url "https://github.com/emreboga/claude-menubar/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "REPLACE_WITH_SHA256"
  license "MIT"
  version "1.0.0"

  head "https://github.com/emreboga/claude-menubar.git", branch: "main"

  depends_on cask: "swiftbar"

  def install
    # Install executable scripts to bin/
    bin.install "scripts/cc-status"
    bin.install "scripts/clear-all"
    bin.install "scripts/focus-terminal"

    # Install shared library to libexec/
    libexec.install "lib/common.sh"

    # Install config to pkgshare/ for reference
    pkgshare.install "config/claude-hooks.json"
  end

  def caveats
    <<~EOS
      Claude Menubar has been installed.

      To finish setup, run the post-install script:
        #{HOMEBREW_PREFIX}/bin/cc-status --setup

      Or manually copy the hooks config to your project:
        cp #{pkgshare}/claude-hooks.json <your-project>/.claude/hooks.json

      Then open SwiftBar and point it at:
        #{bin}/cc-status

      To start on login, configure SwiftBar's plugin directory to include:
        #{bin}

      For more information, visit:
        https://github.com/emreboga/claude-menubar
    EOS
  end

  test do
    assert_predicate bin/"cc-status", :exist?
    assert_predicate bin/"clear-all", :exist?
    assert_predicate bin/"focus-terminal", :exist?
    assert_predicate libexec/"common.sh", :exist?
  end
end
