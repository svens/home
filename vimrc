" load settings
if filereadable($HOME . "/.vim/rc.vim")
    source $HOME/.vim/rc.vim
endif

" overwrite work settings
au! BufRead,BufNewFile /work/transport_relay/** setlocal expandtab shiftwidth=2 softtabstop=2
