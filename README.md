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

### Tools

| Tool | Installation |
|------|--------------|
| Node.js (LTS) | mise |
| Homebrew (Linux) | brew |
| GitHub CLI (`gh`) | brew |
| Git | apt |
| Vim | apt |
| ripgrep | apt |
| lsd | apt |
| Claude Code | npm |

### Zsh Plugins

- `zsh-syntax-highlighting`
- `zsh-autosuggestions`

### Aliases

```bash
alias be="bundle exec"
alias fix-dir-permissions="sudo chown -R claude:claude ."
alias docker-compose="docker compose"
alias ls="lsd"
alias brew-upgrade="brew update && brew upgrade && brew upgrade --cask --greedy"
```

## Volumes

| Host | Container | Permission |
|------|-----------|------------|
| `~/.claude` | `/home/claude/.claude` | RW |
| `~/Projects` | `/home/claude/Projects` | RW |
| `~/.ssh` | `/home/claude/.ssh` | RO |
| `~/.gitconfig` | `/home/claude/.gitconfig` | RO |

## Environment Variables

```bash
CLAUDE_CODE_OAUTH_TOKEN=  # Claude Code authentication token
```
