# path
for dir in ~/bin; do
    [ -d "$dir" ] && path=($dir $path)
done

# fpath
fpath=(
    ~/.zsh_completion.d
    /usr/local/share/zsh/site-functions
    /usr/local/share/zsh-completions
    $fpath
)

# environment
[ -f ~/.env ] && source ~/.env

# prompt
autoload -U colors && colors
[ -z "$SSH_CONNECTION" ] && pc=$reset_color || pc=$fg[cyan]
PROMPT="%{$fg[green]%}%~%{$reset_color%} %{$pc%}%(#.#.$)%{$reset_color%} "

# history
setopt hist_ignore_all_dups
setopt hist_ignore_space
export HISTFILE=~/.histfile
export HISTSIZE=2000
export SAVEHIST=$HISTSIZE

# keys & completion
bindkey -e
bindkey ^U backward-kill-line
autoload -U compinit && compinit
setopt no_auto_menu
zstyle ':completion:*' matcher-list '' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'

# specialized completions
[ -x "$(which kubectl)" ] && source <(kubectl completion zsh)

# aliases
[ -f ~/.aliases ] && source ~/.aliases
