-- fzf lua
vim.keymap.set("n", "<leader>fs", ":FzfLua files<cr>")
vim.keymap.set("n", "<leader>fz", ":FzfLua live_grep<cr>")
vim.keymap.set("n", "<leader>fo", ":FzfLua oldfiles<cr>")

-- tree
vim.keymap.set("n", "<leader>e", ":NvimTreeFindFileToggle<cr>")

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

-- Copilot Chat
vim.keymap.set("n", "<leader>cc", function() require("CopilotChat").open() end, { desc = "CopilotChat - Open" })
vim.keymap.set("n", "<leader>ct", function() require("CopilotChat").toggle() end, { desc = "CopilotChat - Toggle" })
vim.keymap.set("n", "<leader>cq", function()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
  end
end, { desc = "CopilotChat - Quick chat" })
vim.keymap.set("v", "<leader>cq", function()
  local input = vim.fn.input("Quick Chat: ")
  if input ~= "" then
    require("CopilotChat").ask(input, { selection = require("CopilotChat.select").visual })
  end
end, { desc = "CopilotChat - Quick chat" })
vim.keymap.set("v", "<leader>ce", function() require("CopilotChat").ask("Explain this code", { selection = require("CopilotChat.select").visual }) end, { desc = "CopilotChat - Explain" })
vim.keymap.set("v", "<leader>cr", function() require("CopilotChat").ask("Review this code and suggest improvements", { selection = require("CopilotChat.select").visual }) end, { desc = "CopilotChat - Review" })
vim.keymap.set("v", "<leader>cf", function() require("CopilotChat").ask("Fix this code", { selection = require("CopilotChat.select").visual }) end, { desc = "CopilotChat - Fix" })
vim.keymap.set("v", "<leader>co", function() require("CopilotChat").ask("Optimize this code", { selection = require("CopilotChat.select").visual }) end, { desc = "CopilotChat - Optimize" })
vim.keymap.set("v", "<leader>cT", function() require("CopilotChat").ask("Generate tests for this code", { selection = require("CopilotChat.select").visual }) end, { desc = "CopilotChat - Tests" })
vim.keymap.set("v", "<leader>cd", function() require("CopilotChat").ask("Generate documentation for this code", { selection = require("CopilotChat.select").visual }) end, { desc = "CopilotChat - Docs" })

