return {
	'nvim-treesitter/nvim-treesitter',
	lazy = false,
	build = ':TSUpdate',
	opts = {
		ensure_installed = { "lua", "vim", "vimdoc", "python", "javascript", "typescript", "html", "css", "csharp" },
		auto_install = true,
		highlight = {
			enable = true,
		},
	},
}

