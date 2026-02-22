# homebrew-tools

Homebrew tap for tools by emreboga.

## Installation

### claude-menubar

A macOS menubar tool (SwiftBar plugin) that shows Claude Code session status.

```sh
brew tap emreboga/tools
brew install claude-menubar
```

> **Note:** `claude-menubar` depends on [SwiftBar](https://swiftbar.app). If you
> don't have it installed yet, Homebrew will install it automatically.

After installation, symlink the SwiftBar plugin:

```sh
ln -s ~/.claude-menubar/bin/claude-menubar.10s.sh \
      ~/Library/Application\ Support/SwiftBar/Plugins/
```

Then restart Claude Code to load the hooks.

### Configuration

To change your terminal (default is Terminal):

```sh
claude-menubar-setup --terminal Warp
```

Supported terminals: `Terminal`, `iTerm`, `iTerm2`, `Warp`, `Alacritty`, `kitty`, `Hyper`, `WezTerm`, `Ghostty`

## Updating

```sh
brew update
brew upgrade claude-menubar
```

## Uninstalling

```sh
brew uninstall claude-menubar
claude-menubar-uninstall
```
