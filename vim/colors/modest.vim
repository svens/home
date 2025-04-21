hi clear
set background=dark

let colors_name = "modest"

hi Normal       ctermfg=lightgrey
hi Comment      ctermfg=brown
hi Constant     ctermfg=lightgrey
hi String       ctermfg=magenta
hi Folded       ctermfg=cyan
hi Identifier   ctermfg=white cterm=bold
hi Ignore       ctermfg=black
hi NonText      ctermfg=lightgrey
hi PreProc      ctermfg=green cterm=bold
hi Special      ctermfg=magenta cterm=bold
hi SpecialKey   ctermfg=darkgray
hi Statement    ctermfg=white cterm=bold
hi Todo         ctermfg=black ctermbg=brown
hi Type         ctermfg=white cterm=bold
hi RightMargin  ctermfg=red
hi Visual       ctermfg=black ctermbg=gray
hi Search       ctermfg=black ctermbg=darkcyan

hi DiffAdd      ctermfg=black ctermbg=darkgreen
hi DiffChange   ctermfg=none ctermbg=none
hi DiffDelete   ctermfg=none ctermbg=darkred
hi DiffText     ctermfg=yellow ctermbg=darkred

hi Pmenu ctermbg=brown
hi PmenuSel ctermbg=yellow

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
