# claude-code

Docker container for [Claude Code](https://docs.anthropic.com/en-us/docs/claude-code) with pre-configured development tools.

## Prerequisites

- Docker Desktop
- Docker Compose

## Usage

```bash
# Build
docker compose build

# Enter the container
docker compose run --rm claude-docker

# Or run claude directly
docker compose run --rm claude-docker claude
```

## What's included

### System

- Debian Trixie
- `claude` user with sudo access
- Zsh + Oh My Zsh
- Catppuccin tmux theme

### Tools

| Tool | Installation |
|------|--------------|
| Node.js (LTS) | mise |
| Homebrew (Linux) | brew |
| Git | apt |
| GitHub CLI (`gh`) | brew |
| Neovim | brew |
| jq | brew |
| yq | brew |
| tree | brew |
| btop | brew |
| fzf | brew |
| bat | brew |
| fd | brew |
| ripgrep | apt |
| lsd | brew |
| lazygit | brew |
| direnv | brew |
| httpie | brew |
| wget | brew |
| tmux | brew |
| tpack | brew |
| Vim | apt |
| htop | apt |
| unzip | apt |
| Claude Code | npm |

### Zsh Plugins

- `zsh-syntax-highlighting`
- `zsh-autosuggestions`

### Aliases

```bash
alias be="bundle exec"
alias fix-dir-permissions="sudo chown -R claude:claude ."
alias ls="lsd"
alias brew-upgrade="brew update && brew upgrade && brew upgrade --cask --greedy"
alias tmux-main="tmux new-session -A -s main"
```

## Volumes

| Host | Container | Permission |
|------|-----------|------------|
| `~/.claude` | `/home/claude/.claude` | RW |
| `~/Projects` | `/home/claude/Projects` | RW |
| `~/.ssh` | `/home/claude/.ssh` | RO |
| `~/.gitconfig` | `/home/claude/.gitconfig` | RO |
| `./.tmux.conf` | `/home/claude/.tmux.conf` | RO |
| `~/.tmux.conf` | `/home/claude/.tmux.conf` | RO |

## Environment Variables

```bash
CLAUDE_CODE_OAUTH_TOKEN=  # Claude Code authentication token
```
