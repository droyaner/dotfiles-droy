-- Leader key
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Enable true colors for better theming
vim.opt.termguicolors = true

-- Use system clipboard by default
vim.opt.clipboard = "unnamedplus"

-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Show whitespace characters
vim.opt.list = true
vim.opt.listchars = {
  tab = "→ ",       -- Show tabs as →
  trail = "·",      -- Show trailing spaces as ·
  nbsp = "␣",       -- Show non-breaking spaces
  extends = "⟩",    -- Show when line continues beyond screen
  precedes = "⟨",   -- Show when line starts before screen
}

-- Colorscheme is set in lua/plugins/ui.lua
