return {
	"catgoose/nvim-colorizer.lua",
	event = "VeryLazy",
	opts = { -- set to setup table
		lazy_load = true,
		user_default_options = {
			RGB = true, -- #RGB hex codes
			RGBA = true, -- #RGBA hex codes
			RRGGBB = true, -- #RRGGBB hex codes
			RRGGBBAA = true, -- #RRGGBBAA hex codes
			AARRGGBB = true, -- 0xAARRGGBB hex codes
			rgb_fn = true, -- CSS rgb() and rgba() functions
			hsl_fn = true, -- CSS hsl() and hsla() functions
			oklch_fn = true, -- CSS oklch() function
			css = true, -- Enable all CSS *features*:
			-- names, RGB, RGBA, RRGGBB, RRGGBBAA, AARRGGBB, rgb_fn, hsl_fn, oklch_fn
			css_fn = true, -- Enable all CSS *functions*: rgb_fn, hsl_fn, oklch_fn
			-- Tailwind colors.  boolean|'normal'|'lsp'|'both'.  True sets to 'normal'
			tailwind = true, -- Enable tailwind colors
			tailwind_opts = { -- Options for highlighting tailwind names
				-- update_names = false, -- When using tailwind = 'both', update tailwind names from LSP results.  See tailwind section
			},
			-- parsers can contain values used in `user_default_options`
			-- sass = { enable = false, parsers = { "css" } }, -- Enable sass colors
			xterm = true, -- Enable xterm 256-color codes (#xNN, \e[38;5;NNNm)
			-- Highlighting mode.  'background'|'foreground'|'virtualtext'
			mode = "virtualtext", -- Set the display mode
			-- Virtualtext character to use
			virtualtext = "⬤",
			-- Display virtualtext inline with color.  boolean|'before'|'after'.  True sets to 'after'
			virtualtext_inline = "before",
			-- Virtualtext highlight mode: 'background'|'foreground'
			virtualtext_mode = "foreground",
		},
	},
}
