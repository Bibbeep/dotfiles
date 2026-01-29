return {
	{
		"stevearc/oil.nvim",
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {
			delete_to_trash = true,
			view_options = {
				show_hidden = true,
			},
			win_options = {
				signcolumn = "yes:2",
			},
			float = {
				padding = 2,
				max_width = 80,
				max_height = 40,
				border = "rounded",
				win_options = {
					winblend = 0,
				},
			},
			default_file_explorer = true,
			confirmation = {
				border = "rounded",
			},
			columns = {
				"icon",
				{ "mtime", format = "%Y-%m-%d %H:%M:%S" },
			},
		},
		-- Optional dependencies
		dependencies = {
			{
				"nvim-mini/mini.icons",
				opts = {},
			},
		},
		-- dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
		-- Lazy loading is not recommended because it is very tricky to make it work correctly in all situations.
		lazy = false,
	},
	{
		"refractalize/oil-git-status.nvim",
		dependencies = {
			"stevearc/oil.nvim",
		},
		config = true,
	},
	{
		"JezerM/oil-lsp-diagnostics.nvim",
		dependencies = {
			"stevearc/oil.nvim",
		},
		opts = {},
	},
}
