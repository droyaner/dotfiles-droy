return {
	-- Colorscheme
	{
		"folke/tokyonight.nvim",
		version = "*", -- Use latest stable release
		lazy = false,
		priority = 1000,
		config = function()
			require("tokyonight").setup({
				style = "moon", -- moon, storm, night, day
			})
			vim.cmd([[colorscheme tokyonight-moon]])
		end,
	},

	-- File explorer
	{
		"stevearc/oil.nvim",
		version = "*",
		lazy = false,
		config = function()
			require("oil").setup({
				columns = { "icon" },
				keymaps = {
					["<C-h>"] = false,
					["<C-l>"] = false,
					["<C-k>"] = "actions.preview",
					["<C-c>"] = "actions.close",
				},
			})
			-- Keymap to open oil
			vim.keymap.set("n", "-", "<CMD>Oil<CR>", { noremap = true, silent = true })
		end,
	},

	-- Fuzzy finder
	{
		"ibhagwan/fzf-lua",
		version = "*",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		opts = {},
	},

	-- Buffer line
	{
		"akinsho/bufferline.nvim",
		version = "*",
		dependencies = "nvim-tree/nvim-web-devicons",
		opts = {},
	},

	-- Icons (used by multiple plugins)
	{
		"nvim-tree/nvim-web-devicons",
		version = "*",
		lazy = true,
	},

	-- Mini Icons (New standard for icons in Neovim)
	{
		"echasnovski/mini.icons",
		version = "*",
		lazy = false, -- Load immediately to ensure mocking works before other plugins load
		config = function()
			require("mini.icons").setup()
			-- Mock nvim-web-devicons for compatibility
			require("mini.icons").mock_nvim_web_devicons()
		end,
	},
}
