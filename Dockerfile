FROM debian:trixie

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    git \
    gnupg \
    vim \
    sudo \
    build-essential \
    procps \
    file \
    rustc \
    libssl-dev \
    libyaml-dev \
    zlib1g-dev \
    libgmp-dev \
    unzip \
    htop \
    locales \
    && rm -rf /var/lib/apt/lists/*

RUN sed -i '/en_US.UTF-8/s/^# //g' /etc/locale.gen && locale-gen

ENV LANG=en_US.UTF-8
ENV LANGUAGE=en_US:en
ENV LC_ALL=en_US.UTF-8

RUN useradd -m -s /bin/bash claude && \
    echo "claude ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/claude

USER claude

RUN curl https://mise.run | sh

RUN /home/claude/.local/bin/mise use --global nodejs@lts

RUN sudo mkdir -p /home/linuxbrew/.linuxbrew && \
    sudo chown -R claude:claude /home/linuxbrew

RUN git clone --depth=1 https://github.com/Homebrew/brew /home/linuxbrew/.linuxbrew/Homebrew

RUN mkdir -p /home/linuxbrew/.linuxbrew/bin && \
    ln -s /home/linuxbrew/.linuxbrew/Homebrew/bin/brew /home/linuxbrew/.linuxbrew/bin/brew

ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/claude/.local/bin:${PATH}"
ENV HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
ENV HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar"
ENV HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew"

ENV CFLAGS="-Wno-implicit-function-declaration"
ENV CXXFLAGS="-Wno-implicit-function-declaration"

RUN /home/linuxbrew/.linuxbrew/bin/brew update && \
    /home/linuxbrew/.linuxbrew/bin/brew cleanup

RUN /home/linuxbrew/.linuxbrew/bin/brew install git gh jq yq tree btop fzf bat fd ripgrep lazygit direnv httpie wget tmux tmuxpack/tpack/tpack lsd neovim zsh zsh-completions zsh-fast-syntax-highlighting zsh-autosuggestions

RUN echo "/home/linuxbrew/.linuxbrew/bin/zsh" | sudo tee -a /etc/shells

RUN sudo chsh -s /home/linuxbrew/.linuxbrew/bin/zsh claude

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

RUN echo 'eval "$(/home/claude/.local/bin/mise activate zsh)"' >> /home/claude/.zshrc && \
    echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/claude/.zshrc && \
    echo 'export TERM=xterm-256color' >> /home/claude/.zshrc && \
    echo 'fpath=(/home/linuxbrew/.linuxbrew/share/zsh-completions $fpath)' >> /home/claude/.zshrc && \
    echo 'source /home/linuxbrew/.linuxbrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh' >> /home/claude/.zshrc && \
    echo 'source /home/linuxbrew/.linuxbrew/share/zsh-fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh' >> /home/claude/.zshrc && \
    echo '' >> /home/claude/.zshrc && \
    echo 'alias be="bundle exec"' >> /home/claude/.zshrc && \
    echo 'alias fix-dir-permissions="sudo chown -R claude:claude ."' >> /home/claude/.zshrc && \
    echo 'alias ls="lsd"' >> /home/claude/.zshrc && \
    echo 'alias brew-upgrade="brew update && brew upgrade && brew upgrade --cask --greedy"' >> /home/claude/.zshrc && \
    echo 'alias tmux-main="tmux new-session -A -s main"' >> /home/claude/.zshrc

RUN /home/claude/.local/bin/mise exec -- npm install -g @anthropic-ai/claude-code

WORKDIR /app

RUN chown -R claude:claude /app

COPY --chown=claude:claude entrypoint.sh /home/claude/entrypoint.sh
RUN chmod +x /home/claude/entrypoint.sh

ENTRYPOINT ["/home/claude/entrypoint.sh"]
