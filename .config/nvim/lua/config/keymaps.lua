-- fzf lua
vim.keymap.set("n", "<leader>fs", ":FzfLua files<cr>")
vim.keymap.set("n", "<leader>fz", ":FzfLua live_grep<cr>")
vim.keymap.set("n", "<leader>fo", ":FzfLua oldfiles<cr>")

-- tree
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")

-- Buffer navigation
vim.keymap.set("n", "<leader>bn", ":bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bp", ":bprevious<cr>", { desc = "Previous buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete<cr>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bb", ":FzfLua buffers<cr>", { desc = "List buffers" })
-- Quick buffer switching
vim.keymap.set("n", "<Tab>", ":bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<S-Tab>", ":bprevious<cr>", { desc = "Previous buffer" })

-- Window navigation
vim.keymap.set("n", "<leader>wh", "<C-w>h", { desc = "Window left" })
vim.keymap.set("n", "<leader>wj", "<C-w>j", { desc = "Window down" })
vim.keymap.set("n", "<leader>wk", "<C-w>k", { desc = "Window up" })
vim.keymap.set("n", "<leader>wl", "<C-w>l", { desc = "Window right" })
vim.keymap.set("n", "<leader>ws", "<C-w>s", { desc = "Split horizontal" })
vim.keymap.set("n", "<leader>wv", "<C-w>v", { desc = "Split vertical" })
vim.keymap.set("n", "<leader>wq", "<C-w>q", { desc = "Close window" })
vim.keymap.set("n", "<leader>wo", "<C-w>o", { desc = "Close other windows" })
vim.keymap.set("n", "<leader>w=", "<C-w>=", { desc = "Equal window sizes" })


