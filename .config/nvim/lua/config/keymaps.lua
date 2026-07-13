-- fzf lua
local function current_file_dir()
	local file_name = vim.api.nvim_buf_get_name(0)
	if file_name == "" then
		return (vim.uv or vim.loop).cwd()
	end

	return vim.fs.dirname(file_name)
end

vim.keymap.set("n", "<leader>fs", function()
	require("fzf-lua").files()
end, { desc = "Files (project)" })
vim.keymap.set("n", "<leader>ff", function()
	require("fzf-lua").files({ cwd = current_file_dir(), cwd_prompt = false })
end, { desc = "Files (current directory)" })
vim.keymap.set("n", "<leader>fz", function()
	require("fzf-lua").live_grep()
end, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fo", function()
	require("fzf-lua").oldfiles()
end, { desc = "Old files" })

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
