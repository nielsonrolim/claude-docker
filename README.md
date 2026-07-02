# claude-code

Docker container for [Claude Code](https://docs.anthropic.com/en-us/docs/claude-code) with pre-configured development tools.

## Prerequisites

- Docker Desktop
- Docker Compose

## Usage

```bash
# Create your .env file
cp .env.example .env

# Build
docker compose build

# Start the container in the background
docker compose up -d

# Enter the container
docker compose exec claude-docker zsh

# Or run claude directly
docker compose exec claude-docker claude
```

## What's included

### System

- Debian Trixie
- `claude` user with sudo access
- Zsh + Oh My Zsh
- Catppuccin tmux theme

### Tools

| Tool | Installation | Description |
|------|--------------|-------------|
| Node.js (LTS) | mise | JavaScript runtime |
| Homebrew (Linux) | brew | Package manager |
| Zsh | brew | Shell |
| zsh-completions | brew | Additional completion definitions for zsh |
| zsh-fast-syntax-highlighting | brew | Fast syntax highlighting for zsh |
| zsh-autosuggestions | brew | Fish-like autosuggestions for zsh |
| Git | brew | Version control system |
| GitHub CLI (`gh`) | brew | Command-line tool for GitHub |
| Neovim | brew | Text editor |
| jq | brew | Command-line JSON processor |
| yq | brew | Command-line YAML/XML/TOML processor |
| tree | brew | Recursive directory listing |
| btop | brew | Resource monitor |
| fzf | brew | Fuzzy finder |
| bat | brew | `cat` clone with syntax highlighting |
| fd | brew | Simple, fast alternative to `find` |
| ripgrep | brew | Fast recursive line-oriented search tool |
| lsd | brew | Modern `ls` replacement with icons and colors |
| lazygit | brew | Terminal UI for git |
| direnv | brew | Loads/unloads environment variables per directory |
| httpie | brew | User-friendly HTTP client |
| wget | brew | Command-line file downloader |
| tmux | brew | Terminal multiplexer |
| tpack | brew | Plugin manager for tmux |
| Vim | apt | Text editor |
| htop | apt | Interactive process viewer |
| unzip | apt | Extracts `.zip` archives |
| Claude Code | brew | AI coding assistant CLI |

### Zsh Plugins

- `zsh-completions`
- `zsh-fast-syntax-highlighting`
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
| `./.claude.json` | `/home/claude/.claude.json` | RW |
| `./.claude-credentials.json` | `/home/claude/.claude/.credentials.json` | RW |

## Environment Variables

```bash
CLAUDE_CODE_OAUTH_TOKEN=  # Claude Code authentication token
```
