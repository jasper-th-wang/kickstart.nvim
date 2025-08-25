-- [[ Basic Configuration ]]
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.tabstop=4
vim.o.softtabstop=4
vim.o.shiftwidth=4
vim.o.expandtab = true
vim.o.spell = true
vim.o.guifont="JetBrains Mono:h16"
vim.o.smartindent = true
vim.o.scrolloff=8

-- stack: make jump list behave like tag stak
-- view: make sure vim view does not center on the cursor after jumping back
vim.o.jumpoptions="stack,view"
-- Enable relative line numbers
vim.o.relativenumber = true
-- turn hybrid line numbers on
-- :set nu rnu
-- Enable absolute line numbers
vim.opt.number = true

-- Enable relative line numbers
vim.opt.relativenumber = true


-- [[ Basic Keymaps ]]
-- Use visual line movement (wrap-aware) instead of logical lines
vim.keymap.set('', 'k', 'gk')
vim.keymap.set('', 'j', 'gj')

-- Insert mode mapping for 'jj' to escape
vim.keymap.set('i', 'jj', '<Esc>')

-- Visual mode mapping to delete and paste without overwriting the clipboard
vim.keymap.set('x', '<leader>p', '"_dP')

-- Normal and visual mode mappings to yank to the system clipboard
vim.keymap.set('n', '<leader>y', '"+y')
vim.keymap.set('v', '<leader>y', '"+y')

-- Normal mode mapping to yank entire line to the system clipboard
vim.keymap.set('n', '<leader>Y', '"+Y')

-- Normal and visual mode mappings to delete without overwriting the clipboard
vim.keymap.set('n', '<leader>d', '"_d')
vim.keymap.set('v', '<leader>d', '"_d')

-- Normal mode mappings to scroll half page and recenter
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-u>', '<C-u>zz')

-- Normal mode mappings for quick line insertion above and below
vim.keymap.set('n', '<leader>o', 'o<Esc>k')
vim.keymap.set('n', '<leader>O', 'O<Esc>j')

-- Normal mode mapping to copy the current file's directory path to the clipboard
vim.keymap.set('n', '<leader>lp', ':let @*=expand("%:p:h")<CR>')

-- Visual mode mapping to move selected lines up or down
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv")
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv")

-- Keymap to close the current buffer
vim.keymap.set('n', '<leader>bd', ':bd<CR>')

-- Keymap to go to the previous buffer
vim.keymap.set('n', '[b', ':bp<CR>')

-- Keymap to go to the next buffer
vim.keymap.set('n', ']b', ':bn<CR>')

-- Keymap to append a semicolon in insert mode and return to normal mode
vim.keymap.set('i', ';;', '<C-o>A;<Esc>')

-- Open quickfix at bottom of all windows
vim.keymap.set('n', '<leader>qq', ':botright copen<CR>')

-- Close Quickfix
vim.keymap.set('n', '<leader>Q', ':cclose<CR>')

-- Clear Quickfix
vim.keymap.set('n', '<leader>qc', ':cexpr[]<CR>')

-- Navigate quickfix list
vim.keymap.set('n', '[q', ':cprev<CR>', { silent = true, nowait = true })
vim.keymap.set('n', ']q', ':cnext<CR>', { silent = true, nowait = true })

-- Open location list at bottom of all windows
vim.keymap.set('n', '<leader>ll', ':botright lopen<CR>')

-- Close location list
vim.keymap.set('n', '<leader>L', ':lclose<CR>')

-- Clear location list
vim.keymap.set('n', '<leader>lc', ':lexpr[]<CR>')

-- Navigate location list
vim.keymap.set('n', '[l', ':lprev<CR>', { silent = true, nowait = true })
vim.keymap.set('n', ']l', ':lnext<CR>', { silent = true, nowait = true })

-- Folding
vim.keymap.set('n', 'zs', ':setlocal foldmethod=syntax<CR>')

-- TODO: need testing, not sure vim.o is same as setlocal
-- Toggle folding function
local function toggle_fugitive_folds()
    if vim.o.foldmethod == 'syntax' then
        vim.o.foldmethod = 'manual'
        vim.cmd('normal! zE')
        print("Folds: manual (all folds cleared)")
    else
        vim.o.foldmethod = 'syntax'
        print("Folds: syntax")
    end
end

-- Folding keymap using the function
vim.keymap.set('n', 'zs', toggle_fugitive_folds)

-- Tab aliases
vim.api.nvim_create_user_command('Tn', 'tabnew', {})
vim.api.nvim_create_user_command('Tc', 'tabclose', {})

-- Git mappings
vim.api.nvim_create_user_command('Gcc', function()
    vim.fn.feedkeys(':Git commit -m ""' .. vim.api.nvim_replace_termcodes('<Left>', true, false, true))
end, {})

vim.api.nvim_create_user_command('Gcr', function()
    vim.fn.feedkeys(':Git commit -m "refactor"' .. vim.api.nvim_replace_termcodes('<Left>', true, false, true))
end, {})

vim.api.nvim_create_user_command('Gca', 'Git commit --amend', {})

-- Set filetype for Golang templates
vim.api.nvim_create_autocmd({'BufNewFile', 'BufRead'}, {
    pattern = '*.tmpl',
    callback = function()
        vim.bo.filetype = 'html'
    end,
})
