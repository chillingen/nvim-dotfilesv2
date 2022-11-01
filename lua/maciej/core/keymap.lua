vim.g.mapleader = " "

local keymap = vim.keymap

-- general keymaps
-- keymap.set("i", "jk", "<ESC>") >> that's a joke lol

keymap.set("n", "<leader>nh", ":nohl<CR>")
keymap.set("n", "x", "_x")

keymap.set("n", "<leader>to", ":tabnew<CR>")
keymap.set("n", "<leader>tx", ":tabclose<CR>")
keymap.set("n", "<leader>tn", ":tabn<CR>")
keymap.set("n", "<leader>tp", ":tabp<CR>")
