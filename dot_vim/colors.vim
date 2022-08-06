function! GetHighlightProperty(name, attr, mode, default)
    let l:value = synIDattr(synIDtrans(hlID(a:name)), a:attr, a:mode)
    let l:value = synIDattr(synIDtrans(hlID(a:name)), a:attr, a:mode)
    if (l:value != '')
        return l:value
    else
        return a:default
    endif
endfunction

syntax enable "enable colors
colorscheme badwolf
hi Normal guibg=NONE ctermbg=NONE
hi NonText guibg=NONE ctermbg=NONE
hi Comment gui=italic cterm=italic
hi TODO guifg=#000000 guibg=#ffd700 gui=italic,bold ctermbg=220 ctermfg=16 cterm=italic,bold
hi DiffDelete guibg=#5f0000 ctermbg=52
hi DiffAdd guibg=#005f00 ctermbg=22
hi DiffChange guibg=#5f5f00 ctermbg=58
hi DiffText guifg=#5f5f5f guibg=#d7d700 ctermbg=184 ctermfg=59
hi htmlTag guibg=NONE ctermbg=NONE
hi htmlEndTag guibg=NONE ctermbg=NONE
hi illuminatedWord ctermbg=238 cterm=underline guibg=#444444 gui=underline 
hi GitAdd    guifg=#009900 ctermfg=2
hi GitChange guifg=#bbbb00 ctermfg=3
hi GitDelete guifg=#ff2222 ctermfg=1
hi GitChangeDelete guifg=#ff2222 ctermfg=1
"Highlight end of line whitespace in red
highlight BadWhitespace ctermbg=red guibg=red
let m = matchadd('BadWhitespace', '\s\+$')
"Highlight tabs used instead of spaces in red
let m = matchadd('BadWhitespace', '^\t\+')

set t_ZH=[3m  " set proper italics start
set t_ZR=[23m  " set proper italics end
set t_Co=256

if has("termguicolors")
    set termguicolors
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
endif

exec 'hi pythonDocString gui=italic,bold cterm=italic,bold' .
            \' guifg=' . GetHighlightProperty('SpecialComment', 'fg#', 'gui', 'NONE') .
            \' guibg=' . GetHighlightProperty('SpecialComment', 'bg#', 'gui', 'NONE') .
            \' ctermfg=' . GetHighlightProperty('SpecialComment', 'fg', 'cterm', 'NONE') .
            \' ctermbg=' . GetHighlightProperty('SpecialComment', 'bg', 'cterm', 'NONE')
exec 'hi CocExplorerFileDirectoryCollapsed gui=NONE ctermfg=NONE' .
            \' guifg=' . GetHighlightProperty('Directory', 'fg#', 'gui', 'NONE') .
            \' guibg=' . GetHighlightProperty('Directory', 'bg#', 'gui', 'NONE') .
            \' ctermfg=' . GetHighlightProperty('Directory', 'fg', 'cterm', 'NONE') .
            \' ctermbg=' . GetHighlightProperty('Directory', 'bg', 'cterm', 'NONE')
exec 'hi CocExplorerFileDirectoryExpanded gui=NONE ctermfg=NONE' .
            \' guifg=' . GetHighlightProperty('Directory', 'fg#', 'gui', 'NONE') .
            \' guibg=' . GetHighlightProperty('Directory', 'bg#', 'gui', 'NONE') .
            \' ctermfg=' . GetHighlightProperty('Directory', 'fg', 'cterm', 'NONE') .
            \' ctermbg=' . GetHighlightProperty('Directory', 'bg', 'cterm', 'NONE')
exec 'hi CocExplorerFileExpandIcon gui=NONE ctermfg=NONE' .
            \' guifg=' . GetHighlightProperty('Directory', 'fg#', 'gui', 'NONE') .
            \' guibg=' . GetHighlightProperty('Directory', 'bg#', 'gui', 'NONE') .
            \' ctermfg=' . GetHighlightProperty('Directory', 'fg', 'cterm', 'NONE') .
            \' ctermbg=' . GetHighlightProperty('Directory', 'bg', 'cterm', 'NONE')
exec 'hi CocExplorerBufferExpandIcon gui=NONE ctermfg=NONE' .
            \' guifg=' . GetHighlightProperty('Directory', 'fg#', 'gui', 'NONE') .
            \' guibg=' . GetHighlightProperty('Directory', 'bg#', 'gui', 'NONE') .
            \' ctermfg=' . GetHighlightProperty('Directory', 'fg', 'cterm', 'NONE') .
            \' ctermbg=' . GetHighlightProperty('Directory', 'bg', 'cterm', 'NONE')
