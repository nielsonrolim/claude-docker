FROM debian:trixie

RUN apt-get update && apt-get install -y \
    curl \
    ca-certificates \
    gnupg \
    git \
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
    zsh \
    zsh-syntax-highlighting \
    zsh-autosuggestions \
    lsd \
    ripgrep \
    && rm -rf /var/lib/apt/lists/*

RUN useradd -m -s /bin/bash claude && \
    echo "claude ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/claude

USER claude

RUN curl https://mise.run | sh

RUN /home/claude/.local/bin/mise use --global nodejs@lts

RUN git clone --depth=1 https://github.com/Homebrew/brew /home/claude/.linuxbrew/Homebrew

RUN mkdir -p /home/claude/.linuxbrew/bin && \
    ln -s /home/claude/.linuxbrew/Homebrew/bin/brew /home/claude/.linuxbrew/bin/brew

ENV PATH="/home/claude/.linuxbrew/bin:/home/claude/.local/bin:${PATH}"
ENV HOMEBREW_PREFIX="/home/claude/.linuxbrew"
ENV HOMEBREW_CELLAR="/home/claude/.linuxbrew/Cellar"
ENV HOMEBREW_REPOSITORY="/home/claude/.linuxbrew/Homebrew"

RUN /home/claude/.linuxbrew/bin/brew update && \
    /home/claude/.linuxbrew/bin/brew cleanup

RUN /home/claude/.linuxbrew/bin/brew install gh

RUN echo "/usr/bin/zsh" | sudo tee -a /etc/shells

RUN sudo chsh -s /usr/bin/zsh claude

RUN sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

RUN echo 'eval "$(/home/claude/.local/bin/mise activate zsh)"' >> /home/claude/.zshrc && \
    echo 'eval "$(/home/claude/.linuxbrew/bin/brew shellenv)"' >> /home/claude/.zshrc && \
    echo 'source /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh' >> /home/claude/.zshrc && \
    echo 'source /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh' >> /home/claude/.zshrc && \
    echo '' >> /home/claude/.zshrc && \
    echo 'alias be="bundle exec"' >> /home/claude/.zshrc && \
    echo 'alias fix-dir-permissions="sudo chown -R claude:claude ."' >> /home/claude/.zshrc && \
    echo 'alias docker-compose="docker compose"' >> /home/claude/.zshrc && \
    echo 'alias ls="lsd"' >> /home/claude/.zshrc && \
    echo 'alias brew-upgrade="brew update && brew upgrade && brew upgrade --cask --greedy"' >> /home/claude/.zshrc

RUN /home/claude/.local/bin/mise exec -- npm install -g @anthropic-ai/claude-code

WORKDIR /app

RUN chown -R claude:claude /app

COPY --chown=claude:claude entrypoint.sh /home/claude/entrypoint.sh
RUN chmod +x /home/claude/entrypoint.sh

ENTRYPOINT ["/home/claude/entrypoint.sh"]
