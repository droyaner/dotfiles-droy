-- Load config modules
vim.cmd("filetype plugin indent on")
vim.filetype.add({
	extension = {
		hpp = "cpp",
	},
	filename = {
		[".zshrc"] = "zsh",
	},
})

require("config.options")
require("config.keymaps")
require("config.lazy")
