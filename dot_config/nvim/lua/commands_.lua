vim.api.nvim_create_autocmd('TextYankPost', {
    group = vim.api.nvim_create_augroup('highlight_yank', {clear = true}),
    callback = function()
       vim.highlight.on_yank { higroup='HighlightedyankRegion', timeout=500 }
    end
})
vim.api.nvim_create_autocmd('BufWritePre', {
    group = vim.api.nvim_create_augroup('clear_trailing_whitespace', {clear = true}),
    command = [[%s/\s\+$//e]]
})
vim.api.nvim_create_autocmd('BufEnter', {  -- check for changes more often for autoread
    group = vim.api.nvim_create_augroup('check_for_changes', {clear = true}),
    command = 'checkt'
})
vim.api.nvim_create_autocmd('FileType', { -- don't automatically wrap long lines in INSERT
    group = vim.api.nvim_create_augroup('no_wrap_in_insert', {clear = true}),
    command = 'setlocal formatoptions-=t formatoptions+=l'
        -- vim.bo.formatoptions:remove('t')
        -- vim.bo.formatoptions:append('l')
})

vim.api.nvim_create_autocmd('BufWritePost', { -- auto-apply files managed by chezmoi
  group = vim.api.nvim_create_augroup('chezmoi', {clear = true}),
  pattern = vim.fn.expand('~') .. '/.local/share/chezmoi/*',
  command = '!chezmoi apply --source-path "%"',
})

vim.cmd [[
function! DeleteInactiveBufs()
    "From tabpagebuflist() help, get a list of all buffers in all tabs
    let tablist = []
    for i in range(tabpagenr('$'))
        call extend(tablist, tabpagebuflist(i + 1))
    endfor

    "Below originally inspired by Hara Krishna Dara and Keith Roberts
    "http://tech.groups.yahoo.com/group/vim/message/56425
    let nWipeouts = 0
    for i in range(1, bufnr('$'))
        if bufexists(i) && !getbufvar(i,"&mod") && index(tablist, i) == -1
        "bufno exists AND isn't modified AND isn't in the list of buffers open in windows and tabs
            silent exec 'bwipeout' i
            let nWipeouts = nWipeouts + 1
        endif
    endfor
    echomsg nWipeouts . ' buffer(s) wiped out'
endfunction

command! Bdi :call DeleteInactiveBufs()
command! CloseOthers :%bd|e#
command! CloseBuffers :call DeleteInactiveBufs()
]]
