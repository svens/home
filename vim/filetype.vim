if (exists("did_load_filetypes"))
    finish
endif


augroup filetypedetect
    "
    " Check for emacs modeline (only on first line)
    "
    au BufNewFile,BufRead *
        \ if (getline(1) =~? "-*-\.\*C++\.\*-*-") |
        \     set filetype=cpp |
        \ endif
augroup END
