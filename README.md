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
> don't have it installed yet, Homebrew will install it automatically via the
> `swiftbar` cask.

After installation, follow the printed caveats to finish setting up the Claude
hooks so the menubar item updates in real time.

## Updating

```sh
brew update
brew upgrade claude-menubar
```
