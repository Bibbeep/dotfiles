return {
	{
		"loctvl842/monokai-pro.nvim",
		config = function()
			require("monokai-pro").setup()
		end,
	},
	{
		"navarasu/onedark.nvim",
		priority = 1000, -- make sure to load this before all the other start plugins
		config = function()
			require("onedark").setup({
				style = "darker",
			})
			-- require("onedark").load()
		end,
	},
	{
		"olimorris/onedarkpro.nvim",
		priority = 1000, -- Ensure it loads first
		config = function()
			require("onedarkpro").setup({
				options = {
					transparency = true,
					terminal_colors = false,
				},
			})
		end,
	},
	{
		"catppuccin/nvim",
		name = "catppuccin",
		priority = 1000,
	},
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		opts = {},
	},
	{
		"neanias/everforest-nvim",
		version = false,
		lazy = false,
		priority = 1000, -- make sure to load this before all the other start plugins
		-- Optional; default configuration will be used if setup isn't called.
		config = function()
			require("everforest").setup({
				-- Your config here
				transparent_background_level = 1,
			})
		end,
	},
	{
		"rose-pine/neovim",
		name = "rose-pine",
		config = function()
			require("rose-pine").setup({
				styles = {
					bold = true,
					italic = false,
					transparency = false,
				},
			})
			-- vim.cmd("colorscheme rose-pine-moon")
		end,
	},
	{
		"marko-cerovac/material.nvim",
		name = "material",
		config = function()
			require("material").setup({

				contrast = {
					terminal = false, -- Enable contrast for the built-in terminal
					sidebars = false, -- Enable contrast for sidebar-like windows ( for example Nvim-Tree )
					floating_windows = false, -- Enable contrast for floating windows
					cursor_line = false, -- Enable darker background for the cursor line
					lsp_virtual_text = false, -- Enable contrasted background for lsp virtual text
					non_current_windows = false, -- Enable contrasted background for non-current windows
					filetypes = {}, -- Specify which filetypes get the contrasted (darker) background
				},

				styles = { -- Give comments style such as bold, italic, underline etc.
					comments = { --[[ italic = true ]]
					},
					strings = { --[[ bold = true ]]
					},
					keywords = { --[[ underline = true ]]
					},
					functions = { --[[ bold = true, undercurl = true ]]
					},
					variables = {},
					operators = {},
					types = {},
				},

				plugins = { -- Uncomment the plugins that you use to highlight them
					-- Available plugins:
					"blink",
					-- "coc",
					-- "colorful-winsep",
					-- "dap",
					-- "dashboard",
					-- "eyeliner",
					-- "fidget",
					-- "flash",
					-- "gitsigns",
					-- "harpoon",
					-- "hop",
					-- "illuminate",
					-- "indent-blankline",
					-- "lspsaga",
					-- "mini",
					-- "neo-tree",
					-- "neogit",
					-- "neorg",
					-- "neotest",
					-- "noice",
					-- "nvim-cmp",
					-- "nvim-navic",
					-- "nvim-notify",
					-- "nvim-tree",
					-- "nvim-web-devicons",
					-- "rainbow-delimiters",
					-- "sneak",
					-- "telescope",
					-- "trouble",
					-- "which-key",
				},

				disable = {
					colored_cursor = false, -- Disable the colored cursor
					borders = false, -- Disable borders between vertically split windows
					background = false, -- Prevent the theme from setting the background (NeoVim then uses your terminal background)
					term_colors = false, -- Prevent the theme from setting terminal colors
					eob_lines = false, -- Hide the end-of-buffer lines
				},

				high_visibility = {
					lighter = false, -- Enable higher contrast text for lighter style
					darker = false, -- Enable higher contrast text for darker style
				},

				lualine_style = "default", -- Lualine style ( can be 'stealth' or 'default' )

				async_loading = true, -- Load parts of the theme asynchronously for faster startup (turned on by default)

				custom_colors = nil, -- If you want to override the default colors, set this to a function

				custom_highlights = {}, -- Overwrite highlights with your own
			})
		end,
	},
	{
		"Mofiqul/vscode.nvim",
		name = "vscode",
		config = function()
			local c = require("vscode.colors").get_colors()
			require("vscode").setup({
				-- Alternatively set style in setup
				-- style = 'light'

				-- Enable transparent background
				transparent = true,

				-- Enable italic comment
				italic_comments = true,

				-- Enable italic inlay type hints
				italic_inlayhints = true,

				-- Underline `@markup.link.*` variants
				underline_links = true,

				-- Disable nvim-tree background color
				disable_nvimtree_bg = true,

				-- Apply theme colors to terminal
				terminal_colors = true,

				-- Override colors (see ./lua/vscode/colors.lua)
				color_overrides = {
					vscLineNumber = "#FFFFFF",
				},

				-- Override highlight groups (see ./lua/vscode/theme.lua)
				group_overrides = {
					-- this supports the same val table as vim.api.nvim_set_hl
					-- use colors from this colorscheme by requiring vscode.colors!
					Cursor = { fg = c.vscDarkBlue, bg = c.vscLightGreen, bold = true },
				},
			})
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		config = function()
			require("kanagawa").setup({
				compile = true,
				transparent = true,
				undercurl = true,
				colors = {
					theme = {
						all = {
							ui = {
								bg_gutter = "none",
							},
						},
					},
				},
				overrides = function(colors)
					return {
						["@markup.link.url.markdown_inline"] = { link = "Special" }, -- (url)
						["@markup.link.label.markdown_inline"] = { link = "WarningMsg" }, -- [label]
						["@markup.italic.markdown_inline"] = { link = "Exception" }, -- *italic*
						["@markup.raw.markdown_inline"] = { link = "String" }, -- `code`
						["@markup.list.markdown"] = { link = "Function" }, -- + list
						["@markup.quote.markdown"] = { link = "Error" }, -- > blockcode
					}
				end,
			})
			vim.cmd("colorscheme kanagawa-wave")
			-- vim.api.nvim_set_hl(0, "NoicePopup", { bg = "#1F1F28" })
			-- vim.api.nvim_set_hl(0, "NoicePopupBorder", { bg = "#1F1F28" })
		end,
		build = function()
			vim.cmd("KanagawaCompile")
		end,
	},
}
