hi clear
set background=dark

let colors_name = "modest"

hi Normal       ctermfg=lightgrey           guifg=grey90 guibg=black
hi Comment      ctermfg=brown               guifg=darkyellow
hi Constant     ctermfg=lightgrey           guifg=grey90
hi String       ctermfg=darkmagenta         guifg=darkmagenta
hi Folded       ctermfg=cyan                guifg=cyan guibg=black
hi Identifier   ctermfg=white cterm=bold    guifg=grey95
hi Ignore       ctermfg=black
hi NonText      ctermfg=lightgrey
hi PreProc      ctermfg=green cterm=bold    guifg=green
hi Special      ctermfg=magenta cterm=bold  guifg=magenta
hi SpecialKey   ctermfg=darkgray            guifg=gray
hi Statement    ctermfg=white cterm=bold    guifg=grey95
hi Todo         ctermfg=black ctermbg=brown guifg=black guibg=darkyellow
hi Type         ctermfg=white cterm=bold    guifg=grey95
hi RightMargin  ctermfg=red                 guifg=red

hi link Character       Constant
hi link Number          Constant
hi link Boolean         Constant
hi link Float           Constant
hi link Function        Identifier
hi link Conditional     Statement
hi link Repeat          Statement
hi link Label           Statement
hi link Operator        Statement
hi link Keyword         Statement
hi link Exception       Statement
hi link Include         PreProc
hi link Define          PreProc
hi link Macro           PreProc
hi link PreCondit       PreProc
hi link StorageClass    Type
hi link Structure       Type
hi link Typedef         Type
hi link Tag             Special
hi link Specialchar     Special
hi link Delimiter       Special
hi link Specialcomment  Special
hi link Debug           Special
