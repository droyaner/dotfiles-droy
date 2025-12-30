return {
	{
		"echasnovski/mini.comment",
		version = "*",
		event = "VeryLazy",
		config = function()
			require("mini.comment").setup({
				-- Options which control module behavior
				options = {
					-- Function to compute custom 'commentstring' (optional)
					custom_commentstring = nil,

					-- Whether to ignore blank lines
					ignore_blank_line = false,

					-- Whether to recognize as comment only lines without indent
					start_of_line = false,

					-- Whether to force single space inner padding
					pad_comment_parts = true,
				},

				-- Module mappings. Use `''` (empty string) to disable one.
				mappings = {
					-- Toggle comment (like `gcip` - comment inner paragraph) for both
					-- Normal and Visual modes
					comment = "gc",

					-- Toggle comment on current line
					comment_line = "gcc",

					-- Toggle comment on visual selection
					comment_visual = "gc",

					-- Define 'comment' textobject (like `dgc` - delete whole comment block)
					textobject = "gc",
				},
			})
		end,
	},
}
