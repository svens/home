# hassle with PATH
add_path ()
{
    p="$(readlink -f "$1")"
    if [ -d "$p" ] && [[ ":$PATH:" != *":$p:"* ]]; then
        PATH="$p${PATH:+":$PATH"}"
    fi
}

add_path /opt/sbin
add_path /opt/bin
add_path /sbin
add_path /bin
add_path /usr/sbin
add_path /usr/bin
add_path /usr/local/sbin
add_path /usr/local/bin
add_path /work/bin
add_path ${HOME}/bin

# done if non-interactive shell
[[ $- != *i* ]] && return

# completion stuff
for file in ~/.bash_completion.d/*; do
    . $file
done

[ -f ~/.aliases ] && . ~/.aliases
[ -f ~/.dir_colors ] && eval `dircolors -b ~/.dir_colors`

export PS1='[\u@\[\033[01;36m\]\h \[\033[01;32m\]\w\[\033[00m\]]'
export EDITOR=vim
export PAGER=less
export LESS="-R -M -X -F --shift 5"
export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}"erasedups"
export HISTIGNORE="&:ls:ll:l:cd:rm:shutdown:mplayer:mpv"
export HISTSIZE=1000

export LC_COLLATE="POSIX"
export LC_TIME="POSIX"

export BROWSER=chromium
export CHROMIUM_USER_FLAGS="--disk-cache-dir=/dev/shm --disk-cache-size=$((500*1024*1024)) --ppapi-flash-path=/usr/lib/PepperFlash/libpepflashplayer.so"

export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=32:quote=01'

# for debootstrap replace \h -> deb
test -e /etc/debian_chroot && PS1="${PS1/\\h/$(cat /etc/debian_chroot)}"

# Start X if we are on tty6
[ "$(tty)" = "/dev/tty6" ] && exec xinit -- :0 vt6 -nolisten tcp -br
