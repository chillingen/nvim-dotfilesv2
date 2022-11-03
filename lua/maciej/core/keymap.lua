vim.g.mapleader = " "

local keymap = vim.keymap

-- general keymaps
-- keymap.set("i", "jk", "<ESC>") >> that's a joke lol

-- basic needs

keymap.set("n", "<leader>nh", ":nohl<CR>")
-- keymap.set("n", "x", "_x")

-- tab control

keymap.set("n", "<leader>to", ":tabnew<CR>")
keymap.set("n", "<leader>tx", ":tabclose<CR>")
keymap.set("n", "<leader>tn", ":tabnew<CR>")
keymap.set("n", "<leader>tp", ":tabp<CR>")

-- Telescope binds

keymap.set("n", "<leader>ff", ":Telescope find_files<CR>")
keymap.set("n", "<leader>fx", ":Telescope live_grep<CR>")
keymap.set("n", "<leader>fn", ":Telescope buffers<CR>")
keymap.set("n", "<leader>fp", ":Telescope help_tags<CR>")

