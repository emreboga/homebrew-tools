class ClaudeMenubar < Formula
  desc "SwiftBar plugin that shows Claude Code session status in the macOS menubar"
  homepage "https://github.com/emreboga/claude-menubar"
  url "https://github.com/emreboga/claude-menubar/archive/refs/tags/v1.0.0.tar.gz"
  sha256 "eca1bf14c9a84481d0cbc37a5ed8bda19de9b5ed16a355f89abe305b70dd4c4c"
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

  def post_install
    # Run setup.sh to configure ~/.claude-menubar
    system "bash", pkgshare/"setup.sh"

    # Create SwiftBar plugins directory and symlink the plugin
    swiftbar_plugins = Pathname.new(Dir.home)/"Library/Application Support/SwiftBar/Plugins"
    swiftbar_plugins.mkpath
    plugin_link = swiftbar_plugins/"claude-menubar.10s.sh"
    plugin_target = Pathname.new(Dir.home)/".claude-menubar/bin/claude-menubar.10s.sh"
    plugin_link.make_symlink(plugin_target) unless plugin_link.exist?
  end

  def caveats
    <<~EOS
      Claude Menubar has been installed to ~/.claude-menubar
      Plugin symlinked to ~/Library/Application Support/SwiftBar/Plugins/

      Requires SwiftBar. Install it if you haven't:
        brew install --cask swiftbar

      Then restart Claude Code to load the hooks.

      Optional: Change your terminal (default is Terminal):
        claude-menubar-setup --terminal Warp

      Supported terminals: Terminal, iTerm, iTerm2, Warp,
                           Alacritty, kitty, Hyper, WezTerm, Ghostty

      To uninstall completely:
        brew uninstall claude-menubar
        claude-menubar-uninstall

      For more information, visit:
        https://github.com/emreboga/claude-menubar
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
