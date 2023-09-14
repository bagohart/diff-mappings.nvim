# diff-mappings.nvim
Neovim plugin that adds some simple mappings to make `git add --edit` more fun.

## Mappings
No default mappings, create them explicitly:
```lua
vim.keymap.set('n', '<LocalLeader>p', '<Plug>(diff-mappings-n-plus)', { buffer = true })
vim.keymap.set('n', '<LocalLeader>m', '<Plug>(diff-mappings-n-minus)', { buffer = true })
vim.keymap.set('n', '<LocalLeader>c', '<Plug>(diff-mappings-n-context)', { buffer = true })
vim.keymap.set('x', '<LocalLeader>p', '<Plug>(diff-mappings-x-plus)', { buffer = true })
vim.keymap.set('x', '<LocalLeader>m', '<Plug>(diff-mappings-x-minus)', { buffer = true })
vim.keymap.set('x', '<LocalLeader>c', '<Plug>(diff-mappings-x-context)', { buffer = true })
vim.keymap.set('n', ']]', '<Plug>(diff-mappings-next-change)', { buffer = true })
vim.keymap.set('n', '[[', '<Plug>(diff-mappings-previous-change)', { buffer = true })
vim.keymap.set('x', 'i+', '<Plug>(diff-mappings-x-i-plus)', { buffer = true })
vim.keymap.set('x', 'i-', '<Plug>(diff-mappings-x-i-minus)', { buffer = true })
```

## Usage
Use `<Plug>(diff-mappings-[n|x]-[plus|minus|context])` to change the current line/the selected lines to `+`/`-`/` `. Dot-repeatable without dependency on vim-repeat.   
Use `<Plug>(diff-mappings-next/previous-change)` to jump to the next or previous block of lines prefixed with `+` or `-`.  
Use `<Plug>(diff-mappings-x-i-plus/minus)` to select the current or next block of `+` or `-` lines.

## Requirements
Developed and tested on Neovim `0.9.1`.
