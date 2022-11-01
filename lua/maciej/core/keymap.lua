vim.g.mapleader = " "

local keymap = vim.keymap

-- general keymaps
-- keymap.set("i", "jk", "<ESC>") >> that's a joke lol

-- nnoremap <leader>ff <cmd>Telescope find_files<cr>
-- nnoremap <leader>fg <cmd>Telescope live_grep<cr>
-- nnoremap <leader>fb <cmd>Telescope buffers<cr>
-- nnoremap <leader>fh <cmd>Telescope help_tags<cr>

-- basic needs

keymap.set("n", "<leader>nh", ":nohl<CR>")
keymap.set("n", "x", "_x")

-- tab control

keymap.set("n", "<leader>to", ":tabnew<CR>")
keymap.set("n", "<leader>tx", ":tabclose<CR>")
keymap.set("n", "<leader>tn", ":tabn<CR>")
keymap.set("n", "<leader>tp", ":tabp<CR>")

-- Telescope binds

keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
keymap.set("n", "<leader>fx", ":Telescope live_grep<CR>")
keymap.set("n", "<leader>fn", ":Telescope buffers<CR>")
keymap.set("n", "<leader>fp", ":Telescope help_tags<CR>")

-- vim.cmd([[
-- 	imap <silent><expr> <Tab> luasnip#expand_or_jumpable() ? '<Plug>luasnip-expand-or-jump' : '<Tab>' 
-- 	inoremap <silent> <S-Tab> <cmd>lua require'luasnip'.jump(-1)<Cr>
-- 
-- 	snoremap <silent> <Tab> <cmd>lua require('luasnip').jump(1)<Cr>
-- 	snoremap <silent> <S-Tab> <cmd>lua require('luasnip').jump(-1)<Cr>
-- 
-- 	imap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
-- 	smap <silent><expr> <C-E> luasnip#choice_active() ? '<Plug>luasnip-next-choice' : '<C-E>'
-- ]])
