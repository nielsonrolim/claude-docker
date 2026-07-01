#!/usr/bin/zsh
set -e

echo "Claude Code container pronto."
echo "Você está logado como: $(whoami)"
echo "mise: $(mise --version 2>/dev/null || echo 'não encontrado')"
echo "brew: $(brew --version 2>/dev/null | head -1 || echo 'não encontrado')"
echo "zsh: $(zsh --version)"
echo "Use: docker compose exec claude claude"

exec /usr/bin/zsh -l
