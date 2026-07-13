return {
	{
		"folke/which-key.nvim",
		version = "*",
		lazy = false,
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
				{ "<leader>l", group = "LSP" },
				{ "<leader>w", group = "Windows" },
				{ "<leader>b", group = "Buffers" },
				{ "<leader>g", group = "Git" },
				{ "<leader>gt", group = "Git Toggle" },
				{
					"<leader>ls",
					function()
						vim.cmd("LspStart")
					end,
					desc = "Start LSP for current buffer",
				},
				{
					"<leader>lS",
					function()
						vim.cmd("LspStop")
					end,
					desc = "Stop LSP for current buffer",
				},
				{
					"<leader>li",
					function()
						vim.cmd("LspInfo")
					end,
					desc = "Show LSP info",
				},
				{ "<leader>gs", desc = "Stage hunk", mode = { "n", "v" } },
				{ "<leader>gr", desc = "Reset hunk", mode = { "n", "v" } },
				{ "<leader>gS", desc = "Stage buffer" },
				{ "<leader>gu", desc = "Undo stage hunk" },
				{ "<leader>gR", desc = "Reset buffer" },
				{ "<leader>gp", desc = "Preview hunk" },
				{ "<leader>gb", desc = "Blame line" },
				{ "<leader>gd", desc = "Diff this" },
				{ "<leader>gD", desc = "Diff this ~" },
				{ "<leader>gtd", desc = "Toggle deleted" },
				{ "<leader>gtb", desc = "Toggle line blame" },
				{ "<leader>e", desc = "File Explorer" },
				{ "g", group = "Go to (LSP)" },
				{ "[", group = "Previous" },
				{ "]", group = "Next" },
			})
		end,
	},
}
