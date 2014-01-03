cd ${HOME}

sh=/bin/bash
[ "$SHELL" != "$sh" ] && [ -x $sh ] && exec $sh $*
