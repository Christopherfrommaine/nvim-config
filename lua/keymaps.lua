-- convenience shorthand
local map = function(mode, lhs, rhs, desc)
  vim.keymap.set(mode, lhs, rhs, { noremap = true, silent = true, desc = desc })
end

-- Set leader key (must happen before plugins load)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- General
map("n", "<leader>w", "<cmd>write<cr>",  "Save file")
map("n", "<leader>q", "<cmd>quit<cr>",   "Quit")

-- Move between windows
map("n", "<C-h>", "<C-w>h", "Window left")
map("n", "<C-l>", "<C-w>l", "Window right")
map("n", "<C-j>", "<C-w>j", "Window down")
map("n", "<C-k>", "<C-w>k", "Window up")

-- Move selected lines up/down in visual mode
map("v", "J", ":m '>+1<cr>gv=gv", "Move selection down")
map("v", "K", ":m '<-2<cr>gv=gv", "Move selection up")

-- Keep cursor centred when scrolling
map("n", "<C-d>", "<C-d>zz", "Scroll down")
map("n", "<C-u>", "<C-u>zz", "Scroll up")
