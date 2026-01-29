return {
	"folke/noice.nvim",
	event = "VeryLazy",
	opts = {
		views = {
			mini = {
				win_options = {
					winblend = 0,
				},
				border = {
					style = "rounded",
				},
				position = {
					row = -3,
				},
			},
		},
		cmdline = {
			-- Enable command line view by noice, also set messages.enabled to true for enabling this
			enabled = false,
		},
		messages = {
			enabled = false,
		},
		lsp = {
			-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
			},
			signature = {
				auto_open = false,
			},
			progress = {
				enabled = true,
				view = "mini",
			},
			hover = {
				silent = true,
			},
		},
		-- you can enable a preset for easier configuration
		presets = {
			bottom_search = true, -- use a classic bottom cmdline for search
			command_palette = true, -- position the cmdline and popupmenu together
			long_message_to_split = true, -- long messages will be sent to a split
			inc_rename = false, -- enables an input dialog for inc-rename.nvim
			lsp_doc_border = true, -- add a border to hover docs and signature help
		},
	},
	dependencies = {
		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
		"MunifTanjim/nui.nvim",
		-- OPTIONAL:
		--   `nvim-notify` is only needed, if you want to use the notification view.
		--   If not available, we use `mini` as the fallback
		-- "rcarriga/nvim-notify",
	},
	config = function(_, opts)
		require("noice").setup(opts)
	end,
}
