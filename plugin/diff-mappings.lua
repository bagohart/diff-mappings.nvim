vim.keymap.set('n', '<Plug>(git-diff-plus)', function()
    vim.cmd([[keeppatterns substitute/\v^./+/e]])
    vim.cmd([[normal! ``]])
    vim.fn['repeat#set'](vim.api.nvim_replace_termcodes('<Plug>(git-diff-plus)', true, false, true))
end)

vim.keymap.set('n', '<Plug>(git-diff-minus)', function()
    vim.cmd([[keeppatterns substitute/\v^./-/e]])
    vim.cmd([[normal! ``]])
    vim.fn['repeat#set'](vim.api.nvim_replace_termcodes('<Plug>(git-diff-minus)', true, false, true))
end)

vim.keymap.set('n', '<Plug>(git-diff-context)', function()
    vim.cmd([[keeppatterns substitute/\v^./ /e]])
    vim.cmd([[normal! ``]])
    vim.fn['repeat#set'](vim.api.nvim_replace_termcodes('<Plug>(git-diff-context)', true, false, true))
end)

vim.keymap.set('n', '<Plug>(diff-mappings-next-change)', function()
    local save_cursor = vim.fn.getcurpos()
    vim.fn.search([==[\v^[^+-]]==], 'cW')
    local line = vim.fn.search([==[\v^(\+|\-)]==], 'cW')
    if line == 0 then vim.fn.setpos('.', save_cursor) end
end, { buffer = true, desc = "Go to next line starting with '+' or '-'" })

vim.keymap.set('n', '<Plug>(diff-mappings-previous-change)', function()
    local save_cursor = vim.fn.getcurpos()
    vim.fn.search([==[\v^[^+-]]==], 'bcW')
    local line = vim.fn.search([==[\v^(\+|\-)]==], 'bcW')
    if line == 0 then vim.fn.setpos('.', save_cursor) end
end, { buffer = true, desc = "Go to previous line starting with '+' or '-'" })

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
