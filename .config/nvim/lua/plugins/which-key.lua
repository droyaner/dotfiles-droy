return {
  {
    "folke/which-key.nvim",
    version = "*",
    event = "VeryLazy",
    config = function()
      local wk = require("which-key")
      
      wk.setup({
        preset = "modern",
        delay = 500, -- Time in ms to wait before showing which-key
        plugins = {
          marks = true,
          registers = true,
          spelling = {
            enabled = true,
            suggestions = 20,
          },
        },
        win = {
          border = "rounded",
          padding = { 1, 2 },
        },
      })

      -- Register key groups with descriptions
      wk.add({
        { "<leader>f", group = "Find (FZF)" },
        { "<leader>c", group = "Copilot" },
        { "<leader>w", group = "Windows" },
        { "<leader>e", desc = "File Explorer" },
        { "g", group = "Go to (LSP)" },
        { "[", group = "Previous" },
        { "]", group = "Next" },
      })
    end,
  },
}
