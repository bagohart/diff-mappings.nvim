-- This should be doable with lua functions some day, 
-- but so far I couldn't find a working technique for making these repeatable.
-- So, more vimscript it is...
vim.cmd([[
    function! s:diff_mappings_n_plus()
        function! s:inner(...) closure abort
            keeppatterns substitute/\v^./+/e
            normal! ``
        endfunction
        let &opfunc=get(funcref('s:inner'), 'name')
        return 'g@l'
    endfunction
    nnoremap <silent><expr> <Plug>(diff-mappings-n-plus) <sid>diff_mappings_n_plus()
]])

vim.cmd([[
    function! s:diff_mappings_n_minus()
        function! s:inner(...) closure abort
            keeppatterns substitute/\v^./-/e
            normal! ``
        endfunction
        let &opfunc=get(funcref('s:inner'), 'name')
        return 'g@l'
    endfunction
    nnoremap <silent><expr> <Plug>(diff-mappings-n-minus) <sid>diff_mappings_n_minus()
]])

vim.cmd([[
    function! s:diff_mappings_n_context()
        function! s:inner(...) closure abort
            keeppatterns substitute/\v^./ /e
            normal! ``
        endfunction
        let &opfunc=get(funcref('s:inner'), 'name')
        return 'g@l'
    endfunction
    nnoremap <silent><expr> <Plug>(diff-mappings-n-context) <sid>diff_mappings_n_context()
]])

vim.keymap.set('x', '<Plug>(diff-mappings-x-plus)', function()
    local view = vim.fn.winsaveview()
    local esc = vim.api.nvim_replace_termcodes('<esc>', true, false, true)
    vim.api.nvim_feedkeys(esc, 'x', false)
    vim.cmd([['<,'>normal! 0r+]])
    vim.fn.winrestview(view)
end, { buffer = true, desc = "Replace first column of selected lines with '+'" })

vim.keymap.set('x', '<Plug>(diff-mappings-x-minus)', function()
    local view = vim.fn.winsaveview()
    local esc = vim.api.nvim_replace_termcodes('<esc>', true, false, true)
    vim.api.nvim_feedkeys(esc, 'x', false)
    vim.cmd([['<,'>normal! 0r-]])
    vim.fn.winrestview(view)
end, { buffer = true, desc = "Replace first column of selected lines with '-'" })

vim.keymap.set('x', '<Plug>(diff-mappings-x-context)', function()
    local view = vim.fn.winsaveview()
    local esc = vim.api.nvim_replace_termcodes('<esc>', true, false, true)
    vim.api.nvim_feedkeys(esc, 'x', false)
    vim.cmd([['<,'>normal! 0r ]])
    vim.fn.winrestview(view)
end, { buffer = true, desc = "Replace first column of selected lines with ' '" })

vim.keymap.set('n', '<Plug>(diff-mappings-next-change)', function()
    local save_cursor = vim.fn.getcurpos()
    vim.fn.search([==[\v^[^+-]]==], 'cW')
    local line = vim.fn.search([==[\v^(\+|\-)]==], 'cW')
    if line == 0 then vim.fn.setpos('.', save_cursor) end
end, { buffer = true, desc = "Go to next block of '+' or '-' lines" })

vim.keymap.set('n', '<Plug>(diff-mappings-previous-change)', function()
    local save_cursor = vim.fn.getcurpos()
    vim.fn.search([==[\v^[^+-]]==], 'bcW')
    local line = vim.fn.search([==[\v^(\+|\-)]==], 'bcW')
    if line == 0 then vim.fn.setpos('.', save_cursor) end
end, { buffer = true, desc = "Go to previous block of '+' or '-' lines" })

vim.keymap.set('x', '<Plug>(diff-mappings-x-i-plus)', function()
    vim.cmd([[execute "normal! \<Esc>"]])
    local match_last_line = vim.fn.search([==[\v^\+\ze.*\n^[^+]]==], 'cW')
    if match_last_line == 0 then
        vim.cmd([[normal! gv]])
    else
        vim.cmd([[normal! vvm>]])
        vim.fn.search([==[\v^[^+].*\n\zs^\+]==], 'bcW')
        vim.cmd([[normal! m<gvV]])
    end
end, { buffer = true, desc = "Select current or next block of contiguous '+' lines" })

vim.keymap.set('x', '<Plug>(diff-mappings-x-i-minus)', function()
    vim.cmd([[execute "normal! \<Esc>"]])
    local match_last_line = vim.fn.search([==[\v^\-\ze.*\n^[^-]]==], 'cW')
    if match_last_line == 0 then
        vim.cmd([[normal! gv]])
    else
        vim.cmd([[normal! vvm>]])
        vim.fn.search([==[\v^[^-].*\n\zs^\-]==], 'bcW')
        vim.cmd([[normal! m<gvV]])
    end
end, { buffer = true, desc = "Select current or next block of contiguous '-' lines" })
