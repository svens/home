" vim: set filetype=vim:

set nocompatible
syntax enable


"
" simple xterm doesn't colorize always
"
"if &term == "xterm"
"    set term=xterm-color
"endif


"
" encoding
"
set encoding=utf-8
set fileencoding=utf-8
set termencoding=utf-8


"
" tabulation
"
set expandtab
set smarttab
set softtabstop=4
set shiftwidth=4
set tabstop=4


"
" search
"
set incsearch
set hlsearch
set wrapscan


"
" layout
"
set ruler
set showcmd
set cmdheight=1
set wildmenu
set wildmode=longest,list


"
" misc
"
set secure
set backspace=indent,eol,start
set autoindent
set nobackup
set history=50
set foldmethod=marker
set textwidth=78

"
" Undo settings (will not outlive reboot)
"
if v:version >= 703
    set undofile
    set undodir=/tmp
endif


"
" GUI settings
"
set guifont=8x13
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guicursor=a:block


"
" source editing stuff
"
filetype plugin indent on
set cinoptions=l1,g0,t0,j1,(1s,W4,m1,N-s
set formatoptions=tcroqln
set noshowmatch
let loaded_matchparen = 1
let c_no_curly_error = 1


"
" mappings
"
map Q gq
nmap ,s :e %:p:s,.hpp$,.X123X,:s,.cpp$,.hpp,:s,.X123X$,.cpp,<CR>


"
" UltiSnips
"
let g:UltiSnipsSnippetDirectories = ["snippets"]


"
" load colors
"
color modest


"
" Create colorization group
"
match RightMargin /\%<80v.\%>79v/


"
" Show tabs and trailing whitespaces visually
"
if v:version >= 700
    set list listchars=tab:..,trail:.,extends:>,nbsp:_
else
    set list listchars=tab:..,trail:.,extends:>
endif


"
" Disable netrw history
"
let g:netrw_dirhistmax=0
