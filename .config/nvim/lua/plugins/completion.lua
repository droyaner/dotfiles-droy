return {
	-- Blink.cmp - Fast and minimal completion engine
	{
		"saghen/blink.cmp",
		-- Use pre-built binaries for faster loading
		version = "*",
		opts = {
			-- Appearance
			appearance = {
				use_nvim_cmp_as_default = true,
				nerd_font_variant = "mono",
			},

			-- Completion sources
			sources = {
				default = { "lsp", "path", "snippets", "buffer" },
				providers = {
					lsp = {
						name = "LSP",
						module = "blink.cmp.sources.lsp",
						fallbacks = { "buffer" }, -- Use buffer as fallback for LSP
					},
					path = {
						name = "Path",
						module = "blink.cmp.sources.path",
						score_offset = 3,
					},
					snippets = {
						name = "Snippets",
						module = "blink.cmp.sources.snippets",
						score_offset = -3,
					},
					buffer = {
						name = "Buffer",
						module = "blink.cmp.sources.buffer",
					},
				},
			},

			-- Completion behavior
			completion = {
				accept = {
					auto_brackets = {
						enabled = true,
					},
				},
				menu = {
					draw = {
						columns = { { "label", "label_description", gap = 1 }, { "kind_icon", "kind" } },
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 200,
				},
			},

			-- Keybindings
			keymap = {
				preset = "default",
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"] = { "hide" },
				["<CR>"] = { "accept", "fallback" },
				["<Tab>"] = { "select_next", "fallback" },
				["<S-Tab>"] = { "select_prev", "fallback" },
				["<C-n>"] = { "select_next", "fallback" },
				["<C-p>"] = { "select_prev", "fallback" },
				["<C-u>"] = { "scroll_documentation_up", "fallback" },
				["<C-d>"] = { "scroll_documentation_down", "fallback" },
			},

			-- Signature help (function parameters)
			signature = {
				enabled = true,
			},
		},
	},
}
