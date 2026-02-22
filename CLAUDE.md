# Claude Code Context: homebrew-tools

## Overview

A Homebrew tap repository for distributing emreboga's tools via Homebrew. Currently contains the `claude-menubar` formula.

## Repository Structure

```
homebrew-tools/
├── README.md                     # User-facing installation instructions
├── CLAUDE.md                     # This file - context for Claude Code
└── Formula/
    └── claude-menubar.rb         # Homebrew formula for claude-menubar
```

## Formula: claude-menubar

### What It Does

1. Downloads source tarball from `emreboga/claude-menubar` GitHub releases
2. Installs source files to Homebrew's pkgshare directory
3. Creates wrapper scripts (`claude-menubar-setup`, `claude-menubar-uninstall`) in bin
4. Auto-runs `setup.sh` to set up `~/.claude-menubar`
5. Creates SwiftBar plugins directory and symlinks the plugin

### Key Formula Sections

```ruby
url "https://github.com/emreboga/claude-menubar/archive/refs/tags/v1.0.0.tar.gz"
sha256 "..."  # Must match the release tarball

depends_on :macos  # macOS only (uses AppleScript)

def install
  # Install source to pkgshare
  # Create wrapper scripts
  # Auto-run setup.sh
  # Create SwiftBar symlink
end
```

### Updating the Formula

When releasing a new version of claude-menubar:

1. Create release on claude-menubar repo:
   ```sh
   gh release create v1.0.0 --title "v1.0.0" --notes "Release notes"
   ```

2. Get SHA256 of tarball:
   ```sh
   curl -sL https://github.com/emreboga/claude-menubar/archive/refs/tags/v1.0.0.tar.gz | shasum -a 256
   ```

3. Update formula with new version and SHA256

4. Commit and push to homebrew-tools

## User Installation Flow

```sh
brew tap emreboga/tools           # Adds this repo as a tap
brew install claude-menubar       # Installs and auto-configures
# SwiftBar plugin is auto-symlinked
# User just needs to restart Claude Code
```

## Dependencies

- **SwiftBar** (cask): Required but not auto-installed (mentioned in caveats)
- **jq** (optional): For merging hooks during install

## Important Notes

- Formulas cannot depend on casks (`depends_on cask:` is not supported)
- The formula writes to user's home directory (`~/.claude-menubar`) during install
- SwiftBar plugins directory is created at `~/Library/Application Support/SwiftBar/Plugins/`
- Version should stay at 1.0.0 until fully working release is ready
