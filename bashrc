# prepend segment to PATH if exists and not in PATH yet
prepend_path ()
{
    [ -L "$1" ] && segment="$(cd $1 && pwd -P)" || segment="$1"
    if [ -d "$segment" ] && [[ ":$PATH:" != *":$segment:"* ]]; then
        PATH="$segment${PATH:+":$PATH"}"
    fi
}

prepend_path /opt/sbin
prepend_path /opt/bin
prepend_path /sbin
prepend_path /bin
prepend_path /usr/sbin
prepend_path /usr/bin
prepend_path /usr/local/sbin
prepend_path /usr/local/bin
prepend_path /work/bin
prepend_path ${HOME}/bin
prepend_path ${HOME}/proov

# done if non-interactive shell
[[ $- != *i* ]] && return

# environment
[ -f ~/.env ] && . ~/.env
[ -f ~/.aliases ] && . ~/.aliases

# bash-specific env
PS1='\[\033[32m\]\w\[\033[00m\] '
[ -z "$SSH_CONNECTION" ] && PS1="$PS1\$ " || PS1="$PS1\[\033[36m\]\$\[\033[0m\] "
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}"erasedups"
export HISTIGNORE="&:ls:ll:l:cd:rm:shutdown:mplayer:mpv"
export HISTSIZE=1000

# completion stuff
for file in ~/.bash_completion.d/*; do
    . $file
done
if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
fi
