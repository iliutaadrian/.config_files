# for performance
# zmodload zsh/zprof

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH="$HOME/.local/share/nvim/mason/bin":$PATH


# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.

plugins=(git zapmarks)

bindkey '^Z' zapmarks

source $ZSH/oh-my-zsh.sh

eval "$(fzf --zsh)"

export FZF_DEFAULT_OPTS="--preview 'bat --color=always {}' --height 40%"
export FZF_COMPLETION_OPTS='--border --info=inline'

# User configuration

# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
export EDITOR='lvim'
# else
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# TMUX
alias c="clear"
cc() {
  clear
  tmux clear-history
}

# if [ -z $TMUX ]
#   tmux attach -d
# fi

# Aliases
alias vim="lvim"
alias nvim="nvim"

alias life="cd Library/Mobile\ Documents/iCloud\~md\~obsidian/Documents/Life\ OS"
alias ll="ls -la"

function yy() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp"
}

alias x="exit 0"
alias lg="lazygit"

alias nz="cd && lvim .zshrc"
alias nt="cd && lvim .tmux.conf"
alias src="echo 'source ~/.zshrc' && source ~/.zshrc"

# alias python="python3"
# alias pip="pip3"

alias query='python $HOME/.tinyquery/app.py'

alias collect='$HOME/Sites/collect_files.sh'

# Enable vim mode
set -o vi
KEYTIMEOUT=1

# History navigation
bindkey '^P' up-history
bindkey '^N' down-history

# Word manipulation
bindkey '^w' backward-kill-word

# Word navigation
bindkey '^f' forward-word
bindkey '^b' backward-word

# Line navigation
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line

# Char navigation
bindkey '^l' forward-char
bindkey '^h' backward-char

# GG
eval "$(direnv hook zsh)"

# Link Openssl 1.1 -------------------------------------------------------------
# Add to path
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

export PATH="/Users/iliutaadrian/.cargo/bin:$PATH"  

# For compilers to find
export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"

# or pkg-config to find
export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

# RVM
export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# NVM
# export NVM_DIR="$HOME/.nvm"
# [ -s "/usr/local/opt/nvm/nvm.sh" ] && \. "/usr/local/opt/nvm/nvm.sh" # This loads nvm
# [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/usr/local/opt/nvm/etc/bash_completion.d/nvm" # This loads nvm bash_completion
# source ~/.nvm/nvm.sh
# nvm use default --silent

# Lazy load NVM
export NVM_DIR="$HOME/.nvm"
lazy_nvm() {
  unset -f nvm node npm npx
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" --no-use
  nvm use default --silent
}
nvm() {
  lazy_nvm
  nvm "$@"
}
node() {
  lazy_nvm
  node "$@"
}
npm() {
  lazy_nvm
  npm "$@"
}
npx() {
  lazy_nvm
  npx "$@"
}

# Fix postgress error
export PGGSSENCMODE="disable"

# Fix NSCFConstantString initialize error
export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES  

export PYENV_ROOT="$HOME/.pyenv"

export PATH="/usr/local/opt/postgresql@12/bin:$PATH"
# export PGDATA="/usr/local/var/postgresql@12/postgresql.conf"
export PATH="/Users/iliutaadrian/.local/bin:$PATH"

export PATH="/Users/iliutaadrian/Library/Python/3.12/bin:$PATH"

# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/iliutaadrian/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# zprof

