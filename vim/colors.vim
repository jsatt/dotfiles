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
hi link pythonDocString SpecialComment
hi pythonDocString gui=italic,bold cterm=italic,bold
"Highlight end of line whitespace in red
highlight BadWhitespace ctermbg=red guibg=red
let m = matchadd('BadWhitespace', '\s\+$')
"Highlight tabs used instead of spaces in red
let m = matchadd('BadWhitespace', '^\t\+')

set t_ZH=[3m  " set proper italics start
set t_ZR=[23m  " set proper italics end

if has("termguicolors")
    "set t_Co=256
    set termguicolors
    let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
endif

exec 'hi CocExplorerFileDirectoryCollapsed gui=none ctermfg=none' .
            \' guifg=' . GetHighlightProperty('Directory', 'fg#', 'gui', 'none') .
            \' guibg=' . GetHighlightProperty('Directory', 'bg#', 'gui', 'none') .
            \' ctermfg=' . GetHighlightProperty('Directory', 'fg', 'cterm', 'none') .
            \' ctermbg=' . GetHighlightProperty('Directory', 'bg', 'cterm', 'none')
exec 'hi CocExplorerFileDirectoryExpanded gui=none ctermfg=none' .
            \' guifg=' . GetHighlightProperty('Directory', 'fg#', 'gui', 'none') .
            \' guibg=' . GetHighlightProperty('Directory', 'bg#', 'gui', 'none') .
            \' ctermfg=' . GetHighlightProperty('Directory', 'fg', 'cterm', 'none') .
            \' ctermbg=' . GetHighlightProperty('Directory', 'bg', 'cterm', 'none')
exec 'hi CocExplorerFileExpandIcon gui=none ctermfg=none' .
            \' guifg=' . GetHighlightProperty('Directory', 'fg#', 'gui', 'none') .
            \' guibg=' . GetHighlightProperty('Directory', 'bg#', 'gui', 'none') .
            \' ctermfg=' . GetHighlightProperty('Directory', 'fg', 'cterm', 'none') .
            \' ctermbg=' . GetHighlightProperty('Directory', 'bg', 'cterm', 'none')
exec 'hi CocExplorerBufferExpandIcon gui=none ctermfg=none' .
            \' guifg=' . GetHighlightProperty('Directory', 'fg#', 'gui', 'none') .
            \' guibg=' . GetHighlightProperty('Directory', 'bg#', 'gui', 'none') .
            \' ctermfg=' . GetHighlightProperty('Directory', 'fg', 'cterm', 'none') .
            \' ctermbg=' . GetHighlightProperty('Directory', 'bg', 'cterm', 'none')
