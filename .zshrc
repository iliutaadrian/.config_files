# for performance profiling: uncomment both lines and run `zsh -i -c exit`
# zmodload zsh/zprof

source "$HOME/config/zsh/rc"

# zprof

# bun completions
[ -s "/Users/iliutaadrian/.bun/_bun" ] && source "/Users/iliutaadrian/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
