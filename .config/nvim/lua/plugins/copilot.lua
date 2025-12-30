return {
	-- GitHub Copilot
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = {
						accept = "<M-l>", -- Alt+l to accept
						accept_word = "<M-w>", -- Alt+w to accept word
						accept_line = "<M-j>", -- Alt+j to accept line
						next = "<M-n>", -- Alt+n next suggestion
						prev = "<M-p>", -- Alt+p previous suggestion
						dismiss = "<C-]>", -- Ctrl+] dismiss
					},
				},
				panel = {
					enabled = true,
					auto_refresh = false,
					keymap = {
						jump_prev = "[[",
						jump_next = "]]",
						accept = "<CR>",
						refresh = "gr",
						open = "<M-CR>", -- Alt+Enter to open panel
					},
				},
				filetypes = {
					yaml = false,
					markdown = false,
					help = false,
					gitcommit = false,
					gitrebase = false,
					["."] = false,
				},
			})
		end,
	},

	-- Copilot Chat
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		dependencies = {
			{ "zbirenbaum/copilot.lua" },
			{ "nvim-lua/plenary.nvim" },
		},
		opts = {
			debug = false,
			window = {
				layout = "vertical", -- 'vertical', 'horizontal', 'float'
				width = 0.4, -- Width of chat window
				height = 0.6,
				border = "rounded",
			},
			mappings = {
				complete = {
					detail = "Use @<Tab> or /<Tab> for options.",
					insert = "<Tab>",
				},
				close = {
					normal = "q",
					insert = "<C-c>",
				},
				reset = {
					normal = "<C-r>",
					insert = "<C-r>",
				},
				submit_prompt = {
					normal = "<CR>",
					insert = "<C-s>",
				},
			},
		},
		config = function(_, opts)
			local chat = require("CopilotChat")
			chat.setup(opts)
		end,
		keys = {
			-- Quick chat with current selection
			{
				"<leader>ccq",
				function()
					local input = vim.fn.input("Quick Chat: ")
					if input ~= "" then
						require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
					end
				end,
				desc = "CopilotChat - Quick chat",
				mode = { "n", "v" },
			},
			-- Open chat window
			{
				"<leader>ccc",
				function()
					require("CopilotChat").open()
				end,
				desc = "CopilotChat - Open chat window",
			},
			-- Toggle chat window
			{
				"<leader>ccT",
				function()
					require("CopilotChat").toggle()
				end,
				desc = "CopilotChat - Toggle chat window",
			},
			-- Explain code
			{
				"<leader>cce",
				function()
					require("CopilotChat").ask(
						"Explain this code",
						{ selection = require("CopilotChat.select").visual }
					)
				end,
				desc = "CopilotChat - Explain code",
				mode = "v",
			},
			-- Review code
			{
				"<leader>ccr",
				function()
					require("CopilotChat").ask(
						"Review this code and suggest improvements",
						{ selection = require("CopilotChat.select").visual }
					)
				end,
				desc = "CopilotChat - Review code",
				mode = "v",
			},
			-- Fix code
			{
				"<leader>ccf",
				function()
					require("CopilotChat").ask("Fix this code", { selection = require("CopilotChat.select").visual })
				end,
				desc = "CopilotChat - Fix code",
				mode = "v",
			},
			-- Optimize code
			{
				"<leader>cco",
				function()
					require("CopilotChat").ask(
						"Optimize this code",
						{ selection = require("CopilotChat.select").visual }
					)
				end,
				desc = "CopilotChat - Optimize code",
				mode = "v",
			},
			-- Generate tests
			{
				"<leader>cct",
				function()
					require("CopilotChat").ask(
						"Generate tests for this code",
						{ selection = require("CopilotChat.select").visual }
					)
				end,
				desc = "CopilotChat - Generate tests",
				mode = "v",
			},
			-- Generate docs
			{
				"<leader>ccd",
				function()
					require("CopilotChat").ask(
						"Generate documentation for this code",
						{ selection = require("CopilotChat.select").visual }
					)
				end,
				desc = "CopilotChat - Generate docs",
				mode = "v",
			},
		},
	},
}
